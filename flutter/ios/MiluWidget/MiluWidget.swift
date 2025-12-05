//
//  MiluWidget.swift
//  MiluWidget
//
//  Created by aphlo on 2025/12/04.
//

import WidgetKit
import SwiftUI

// MARK: - Data Models

struct WidgetChild: Codable {
    let id: String
    let name: String
    let birthday: String
}

struct WidgetRecord: Codable {
    let id: String
    let type: String
    let at: String
    let amount: Int?
    let note: String?
}

struct WidgetData: Codable {
    let lastUpdated: String?
    let selectedChildId: String?
    let children: [WidgetChild]?
    let recentRecords: [String: [WidgetRecord]]?
}

// MARK: - App Group Helper

struct AppGroupHelper {
    static var appGroupId: String {
        // Bundle Identifierに".stg"が含まれていればSTG環境
        let bundleId = Bundle.main.bundleIdentifier ?? ""
        if bundleId.contains(".stg") {
            return "group.com.aphlo.babymomdiary.stg"
        } else {
            return "group.com.aphlo.babymomdiary"
        }
    }

    static func loadWidgetData() -> WidgetData? {
        guard let userDefaults = UserDefaults(suiteName: appGroupId) else {
            return nil
        }

        guard let jsonString = userDefaults.string(forKey: "widget_data") else {
            return nil
        }

        guard let data = jsonString.data(using: .utf8) else {
            return nil
        }

        do {
            return try JSONDecoder().decode(WidgetData.self, from: data)
        } catch {
            print("Failed to decode widget data: \(error)")
            return nil
        }
    }
}

// MARK: - Timeline Provider

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> WidgetEntry {
        WidgetEntry(
            date: Date(),
            childName: "---",
            childAge: "---",
            records: []
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
        guard let widgetData = AppGroupHelper.loadWidgetData(),
              let children = widgetData.children,
              !children.isEmpty else {
            return WidgetEntry(
                date: Date(),
                childName: "データなし",
                childAge: "アプリを開いてください",
                records: []
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
        let displayRecords = records.prefix(3).map { record in
            DisplayRecord(
                type: record.type,
                time: formatTime(record.at),
                elapsed: calculateElapsed(from: record.at)
            )
        }

        return WidgetEntry(
            date: Date(),
            childName: selectedChild.name,
            childAge: age,
            records: Array(displayRecords)
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
        return timeFormatter.string(from: date)
    }

    private func calculateElapsed(from isoString: String) -> String {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]

        guard let date = formatter.date(from: isoString) else {
            formatter.formatOptions = [.withInternetDateTime]
            guard let date = formatter.date(from: isoString) else {
                return ""
            }
            return calculateElapsedFromDate(date)
        }

        return calculateElapsedFromDate(date)
    }

    private func calculateElapsedFromDate(_ date: Date) -> String {
        let now = Date()
        let interval = now.timeIntervalSince(date)

        if interval < 60 {
            return "たった今"
        } else if interval < 3600 {
            let minutes = Int(interval / 60)
            return "\(minutes)分前"
        } else if interval < 86400 {
            let hours = Int(interval / 3600)
            return "\(hours)時間前"
        } else {
            let days = Int(interval / 86400)
            return "\(days)日前"
        }
    }
}

// MARK: - Entry

struct WidgetEntry: TimelineEntry {
    let date: Date
    let childName: String
    let childAge: String
    let records: [DisplayRecord]
}

struct DisplayRecord {
    let type: String
    let time: String
    let elapsed: String

    var icon: String {
        switch type {
        case "breastLeft", "breastRight":
            return "figure.child.and.lock"
        case "formula":
            return "cup.and.saucer"
        case "pee":
            return "drop"
        case "poop":
            return "leaf"
        case "temperature":
            return "thermometer"
        case "pumped":
            return "cup.and.saucer"
        default:
            return "note.text"
        }
    }

    var displayName: String {
        switch type {
        case "breastLeft":
            return "授乳(左)"
        case "breastRight":
            return "授乳(右)"
        case "formula":
            return "ミルク"
        case "pee":
            return "おしっこ"
        case "poop":
            return "うんち"
        case "temperature":
            return "体温"
        case "pumped":
            return "搾母乳"
        default:
            return "その他"
        }
    }
}

// MARK: - Widget Views

struct MiluWidgetEntryView: View {
    @Environment(\.widgetFamily) var family
    var entry: Provider.Entry

    var body: some View {
        switch family {
        case .systemSmall:
            SmallWidgetView(entry: entry)
        case .systemMedium:
            MediumWidgetView(entry: entry)
        default:
            SmallWidgetView(entry: entry)
        }
    }
}

struct SmallWidgetView: View {
    var entry: WidgetEntry

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            // Header
            HStack {
                Text(entry.childName)
                    .font(.headline)
                    .fontWeight(.bold)
                Spacer()
            }

            Text(entry.childAge)
                .font(.caption)
                .foregroundColor(.secondary)

            Spacer()

            // Latest record
            if let record = entry.records.first {
                HStack(spacing: 8) {
                    Image(systemName: record.icon)
                        .font(.title2)
                        .foregroundColor(.blue)

                    VStack(alignment: .leading, spacing: 2) {
                        Text(record.displayName)
                            .font(.subheadline)
                            .fontWeight(.medium)

                        HStack(spacing: 4) {
                            Text(record.time)
                                .font(.caption)
                            Text(record.elapsed)
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                    }
                }
            } else {
                Text("記録がありません")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
        .padding()
    }
}

struct MediumWidgetView: View {
    var entry: WidgetEntry

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            // Header
            HStack {
                Text(entry.childName)
                    .font(.headline)
                    .fontWeight(.bold)

                Text(entry.childAge)
                    .font(.caption)
                    .foregroundColor(.secondary)

                Spacer()
            }

            // Records (3 columns)
            HStack(spacing: 12) {
                ForEach(0..<3, id: \.self) { index in
                    if index < entry.records.count {
                        RecordCardView(record: entry.records[index])
                    } else {
                        EmptyRecordCardView()
                    }
                }
            }
        }
        .padding()
    }
}

struct RecordCardView: View {
    let record: DisplayRecord

    var body: some View {
        VStack(spacing: 4) {
            Image(systemName: record.icon)
                .font(.title2)
                .foregroundColor(.blue)

            Text(record.displayName)
                .font(.caption2)
                .fontWeight(.medium)
                .lineLimit(1)

            Text(record.time)
                .font(.caption)

            Text(record.elapsed)
                .font(.caption2)
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 8)
        .background(Color(.systemGray6))
        .cornerRadius(8)
    }
}

struct EmptyRecordCardView: View {
    var body: some View {
        VStack(spacing: 4) {
            Image(systemName: "minus")
                .font(.title2)
                .foregroundColor(.gray)

            Text("--")
                .font(.caption2)
                .fontWeight(.medium)

            Text("--:--")
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 8)
        .background(Color(.systemGray6))
        .cornerRadius(8)
    }
}

// MARK: - Widget Definition

struct MiluWidget: Widget {
    let kind: String = "MiluWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            if #available(iOS 17.0, *) {
                MiluWidgetEntryView(entry: entry)
                    .containerBackground(.fill.tertiary, for: .widget)
            } else {
                MiluWidgetEntryView(entry: entry)
                    .padding()
                    .background()
            }
        }
        .configurationDisplayName("milu")
        .description("育児記録をすばやく確認")
        .supportedFamilies([.systemSmall, .systemMedium])
    }
}

// MARK: - Preview

#Preview(as: .systemSmall) {
    MiluWidget()
} timeline: {
    WidgetEntry(
        date: .now,
        childName: "たろう",
        childAge: "1歳2ヶ月",
        records: [
            DisplayRecord(type: "formula", time: "14:30", elapsed: "30分前")
        ]
    )
}

#Preview(as: .systemMedium) {
    MiluWidget()
} timeline: {
    WidgetEntry(
        date: .now,
        childName: "たろう",
        childAge: "1歳2ヶ月",
        records: [
            DisplayRecord(type: "breastRight", time: "12:00", elapsed: "2時間前"),
            DisplayRecord(type: "formula", time: "14:30", elapsed: "30分前"),
            DisplayRecord(type: "pee", time: "13:45", elapsed: "1時間前")
        ]
    )
}
