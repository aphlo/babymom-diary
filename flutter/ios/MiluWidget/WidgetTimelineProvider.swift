import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> WidgetEntry {
        WidgetEntry(
            date: Date(),
            childName: "---",
            childAge: "---",
            records: [],
            latestRecord: nil,
            settings: .default
        )
    }

    func getSnapshot(in context: Context, completion: @escaping (WidgetEntry) -> ()) {
        let entry = createEntry()
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<WidgetEntry>) -> ()) {
        let entry = createEntry()

        // 15分後に更新
        let nextUpdate = Calendar.current.date(byAdding: .minute, value: 15, to: Date())!
        let timeline = Timeline(entries: [entry], policy: .after(nextUpdate))
        completion(timeline)
    }

    private func createEntry() -> WidgetEntry {
        let settings = AppGroupHelper.loadWidgetSettings()
        let mediumSettings = settings.mediumWidget

        guard let widgetData = AppGroupHelper.loadWidgetData(),
              let children = widgetData.children,
              !children.isEmpty else {
            return WidgetEntry(
            date: Date(),
            childName: "データなし",
            childAge: "アプリを開いてください",
            records: [],
            latestRecord: nil,
            settings: settings
        )
    }

        // 選択中の子供を取得
        let selectedChild: WidgetChild
        if let selectedId = widgetData.selectedChildId,
           let child = children.first(where: { $0.id == selectedId }) {
            selectedChild = child
        } else {
            selectedChild = children[0]
        }

        // 年齢を計算
        let age = calculateAge(from: selectedChild.birthday)

        // 記録を取得
        let records = widgetData.recentRecords?[selectedChild.id] ?? []
        let validRecords = filterValidRecords(records)
        let recordTypes = normalizedDisplayTypes(from: mediumSettings.displayRecordTypes)
        let displayRecords = recordTypes.map { type in
            if let record = findLatestRecord(for: type, in: validRecords) {
                return DisplayRecord(
                    type: record.type,
                    time: formatTime(record.at),
                    elapsed: calculateElapsedJapanese(from: record.at),
                    elapsedShort: calculateElapsedShort(from: record.at),
                    isPlaceholder: false,
                    isLatest: false
                )
            } else {
                return DisplayRecord(
                    type: type,
                    time: "--:--",
                    elapsed: "",
                    elapsedShort: "",
                    isPlaceholder: true,
                    isLatest: false
                )
            }
        }

        let latestRecord = createLatestRecord(from: validRecords)

        return WidgetEntry(
            date: Date(),
            childName: selectedChild.name,
            childAge: age,
            records: Array(displayRecords.prefix(3)),
            latestRecord: latestRecord,
            settings: settings
        )
    }

    private func calculateAge(from birthdayString: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"

        guard let birthday = formatter.date(from: birthdayString) else {
            return "---"
        }

        let calendar = Calendar.current
        let now = Date()
        let components = calendar.dateComponents([.year, .month, .day], from: birthday, to: now)

        if let years = components.year, years > 0 {
            if let months = components.month {
                return "\(years)歳\(months)ヶ月"
            }
            return "\(years)歳"
        } else if let months = components.month, months > 0 {
            if let days = components.day {
                return "\(months)ヶ月\(days)日"
            }
            return "\(months)ヶ月"
        } else if let days = components.day {
            return "\(days)日目"
        }

        return "0日目"
    }

    private func parseIsoDate(_ isoString: String) -> Date? {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        if let date = formatter.date(from: isoString) {
            return date
        }
        formatter.formatOptions = [.withInternetDateTime]
        return formatter.date(from: isoString)
    }

    private func createLatestRecord(from records: [WidgetRecord]) -> DisplayRecord? {
        guard let latest = records.max(by: { lhs, rhs in
            guard let lhsDate = parseIsoDate(lhs.at), let rhsDate = parseIsoDate(rhs.at) else { return false }
            return lhsDate < rhsDate
        }), let latestDate = parseIsoDate(latest.at) else {
            return nil
        }

        return DisplayRecord(
            type: latest.type,
            time: formatTimeFromDate(latestDate),
            elapsed: calculateElapsedJapaneseFromDate(latestDate),
            elapsedShort: calculateElapsedShortFromDate(latestDate),
            isPlaceholder: false,
            isLatest: true
        )
    }

    private func filterValidRecords(_ records: [WidgetRecord]) -> [WidgetRecord] {
        let now = Date()
        let cutoff = now.addingTimeInterval(-24 * 60 * 60)

        return records.filter { record in
            guard let date = parseIsoDate(record.at) else { return false }
            if date > now { return false }
            return date >= cutoff
        }
    }

    private func normalizedDisplayTypes(from rawTypes: [String]) -> [String] {
        let types = rawTypes.isEmpty ? MediumWidgetSettings.default.displayRecordTypes : rawTypes
        if types.count >= 3 { return Array(types.prefix(3)) }

        var result = types
        while result.count < 3 {
            result.append("other")
        }
        return result
    }

    private func findLatestRecord(for typeOrCategory: String, in records: [WidgetRecord]) -> WidgetRecord? {
        let targets: [String]
        switch typeOrCategory {
        case "breast", "breastRight", "breastLeft":
            targets = ["breastRight", "breastLeft"]
        default:
            targets = [typeOrCategory]
        }

        var latestRecord: WidgetRecord?
        var latestDate: Date?

        for record in records {
            guard targets.contains(record.type),
                  let date = parseIsoDate(record.at) else { continue }

            if let currentLatest = latestDate {
                if date > currentLatest {
                    latestRecord = record
                    latestDate = date
                }
            } else {
                latestRecord = record
                latestDate = date
            }
        }

        return latestRecord
    }

    private func formatTime(_ isoString: String) -> String {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]

        guard let date = formatter.date(from: isoString) else {
            // フォーマットが違う場合は別のパターンを試す
            formatter.formatOptions = [.withInternetDateTime]
            guard let date = formatter.date(from: isoString) else {
                return "--:--"
            }
            return formatTimeFromDate(date)
        }

        return formatTimeFromDate(date)
    }

    private func formatTimeFromDate(_ date: Date) -> String {
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "HH:mm"
        timeFormatter.timeZone = TimeZone.current
        return timeFormatter.string(from: date)
    }

    // MARK: - Elapsed Time (Japanese for Home Screen)

    private func calculateElapsedJapanese(from isoString: String) -> String {
        guard let date = parseIsoDate(isoString) else { return "" }
        return calculateElapsedJapaneseFromDate(date)
    }

    private func calculateElapsedJapaneseFromDate(_ date: Date) -> String {
        let now = Date()
        let interval = now.timeIntervalSince(date)

        if interval < 60 {
            return "たった今"
        } else if interval < 3600 {
            let minutes = Int(interval / 60)
            return "\(minutes)分前"
        } else if interval < 86400 {
            let hours = Int(interval / 3600)
            let minutes = Int((interval.truncatingRemainder(dividingBy: 3600)) / 60)
            if minutes > 0 {
                return "\(hours)時間\(minutes)分前"
            } else {
                return "\(hours)時間前"
            }
        } else {
            let days = Int(interval / 86400)
            return "\(days)日前"
        }
    }

    // MARK: - Elapsed Time (Short for Lock Screen)

    private func calculateElapsedShort(from isoString: String) -> String {
        guard let date = parseIsoDate(isoString) else { return "" }
        return calculateElapsedShortFromDate(date)
    }

    private func calculateElapsedShortFromDate(_ date: Date) -> String {
        let now = Date()
        let interval = now.timeIntervalSince(date)

        if interval < 60 {
            return "<1m"
        } else if interval < 3600 {
            let minutes = Int(interval / 60)
            return "\(minutes)m"
        } else if interval < 86400 {
            let hours = Int(interval / 3600)
            let minutes = Int((interval.truncatingRemainder(dividingBy: 3600)) / 60)
            if minutes > 0 {
                return "\(hours)h\(minutes)m"
            } else {
                return "\(hours)h"
            }
        } else {
            let days = Int(interval / 86400)
            return "\(days)d"
        }
    }

}
