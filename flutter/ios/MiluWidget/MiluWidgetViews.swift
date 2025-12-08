import SwiftUI
import WidgetKit

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
    @Environment(\.colorScheme) var colorScheme
    var entry: WidgetEntry

    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            // Header
            HStack {
                Text(entry.childName)
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(WidgetColors.textPrimary(for: colorScheme))
                Spacer()
            }

            Text(entry.childAge)
                .font(.caption2)
                .foregroundColor(WidgetColors.textSecondary(for: colorScheme))

            Spacer()

            // Latest record
            if let record = entry.records.first {
                HStack(spacing: 6) {
                    Text(record.emoji)
                        .font(.title3)

                    VStack(alignment: .leading, spacing: 2) {
                        Text(record.displayName)
                            .font(.caption2)
                            .fontWeight(.regular)
                            .foregroundColor(WidgetColors.textSecondary(for: colorScheme))

                        VStack(alignment: .leading, spacing: 1) {
                            Text(record.time)
                                .font(.title3)
                                .fontWeight(.bold)
                                .foregroundColor(WidgetColors.textTime(for: colorScheme))
                            Text(record.elapsed)
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .foregroundColor(WidgetColors.textAgo(for: colorScheme))
                        }
                    }
                }
            } else {
                Text("記録がありません")
                    .font(.caption)
                    .foregroundColor(WidgetColors.textSecondary(for: colorScheme))
            }
        }
        .padding()
    }
}

struct MediumWidgetView: View {
    @Environment(\.colorScheme) var colorScheme
    var entry: WidgetEntry

    var body: some View {
        let mediumSettings = entry.settings.mediumWidget
        let quickActions = normalizedQuickActions(from: mediumSettings.quickActionTypes)
        let records = entry.records

        VStack(alignment: .leading, spacing: 6) {
            // Header
            HStack {
                Text(entry.childName)
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(WidgetColors.textPrimary(for: colorScheme))

                Text(entry.childAge)
                    .font(.caption2)
                    .foregroundColor(WidgetColors.textSecondary(for: colorScheme))

                Spacer()
            }

            // Records (3 columns)
            HStack(spacing: 6) {
                ForEach(0..<min(3, records.count), id: \.self) { index in
                    RecordCardView(record: records[index])
                }
            }

            // Quick Actions (5 buttons)
            HStack(spacing: 4) {
                ForEach(0..<min(5, quickActions.count), id: \.self) { index in
                    let action = quickActions[index]
                    Link(destination: URL(string: "milu://record/add?type=\(action.type)")!) {
                        Text(action.emoji)
                            .font(.title3)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 5)
                            .background(WidgetColors.cardBackground(for: colorScheme))
                            .cornerRadius(8)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(WidgetColors.cardBorder(for: colorScheme), lineWidth: 1)
                            )
                    }
                }
            }
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 8)
    }

    private func normalizedQuickActions(from rawTypes: [String]) -> [(type: String, emoji: String)] {
        let types = rawTypes.isEmpty
            ? MediumWidgetSettings.default.quickActionTypes
            : rawTypes

        return types.map { type in
            (type: type, emoji: emoji(for: type))
        }
    }

    private func emoji(for type: String) -> String {
        switch type {
        case "breast", "breastLeft", "breastRight":
            return "🤱"
        case "formula":
            return "🍼"
        case "pump":
            return "🥛"
        case "pee":
            return "💧"
        case "poop":
            return "💩"
        case "temperature":
            return "🌡️"
        default:
            return "📝"
        }
    }
}

struct RecordCardView: View {
    @Environment(\.colorScheme) var colorScheme
    let record: DisplayRecord

    var body: some View {
        VStack(spacing: 1) {
            Text(record.emoji)
                .font(.title2)
                .foregroundColor(record.isPlaceholder
                    ? WidgetColors.textSecondary(for: colorScheme)
                    : WidgetColors.textTime(for: colorScheme))

            Text(record.displayName)
                .font(.caption2)
                .fontWeight(.medium)
                .foregroundColor(WidgetColors.textSecondary(for: colorScheme))
                .lineLimit(1)
                .minimumScaleFactor(0.8)

            Text(record.time)
                .font(.footnote)
                .fontWeight(.semibold)
                .foregroundColor(record.isPlaceholder
                    ? WidgetColors.textSecondary(for: colorScheme)
                    : WidgetColors.textTime(for: colorScheme))

            Text(record.elapsed)
                .font(.caption2)
                .fontWeight(.semibold)
                .foregroundColor(WidgetColors.textAgo(for: colorScheme))
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 5)
        .background(WidgetColors.cardBackground(for: colorScheme))
        .cornerRadius(10)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(WidgetColors.cardBorder(for: colorScheme), lineWidth: 1)
        )
    }
}
