import SwiftUI
import WidgetKit

struct MiluWidgetEntryView: View {
    @Environment(\.widgetFamily) var family
    @Environment(\.colorScheme) var colorScheme
    var entry: Provider.Entry

    var body: some View {
        if #available(iOS 17.0, *) {
            content
                .containerBackground(for: .widget) {
                        WidgetColors.background(for: colorScheme)
                }
        } else {
            content
                .background(
                    Group {
                            WidgetColors.background(for: colorScheme)
                    }
                )
        }
    }

    @ViewBuilder
    private var content: some View {
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
                VStack(alignment: .leading, spacing: 4) {
                    // 1行目: 絵文字 + 種別
                    HStack(spacing: 6) {
                        Text(record.emoji)
                            .font(.title3)
                        Text(record.displayName)
                            .font(.caption2)
                            .fontWeight(.regular)
                            .foregroundColor(WidgetColors.textSecondary(for: colorScheme))
                    }

                    // 2行目: 記録時間
                    Text(record.time)
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(WidgetColors.textTime(for: colorScheme))

                    // 3行目: 経過時間
                    Text(record.elapsed)
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundColor(WidgetColors.textAgo(for: colorScheme))
                        .lineLimit(1)
                        .minimumScaleFactor(0.7)
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
                            .background(GlossyCardBackground(cornerRadius: 8, colorScheme: colorScheme))
                            .shadow(color: Color.black.opacity(colorScheme == .dark ? 0.4 : 0.15), radius: 5, x: 0, y: 3)
                            .overlay(GlossyCardOverlay(cornerRadius: 8, colorScheme: colorScheme))
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
                .lineLimit(1)
                .minimumScaleFactor(0.8)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 5)
        .background(GlossyCardBackground(cornerRadius: 10, colorScheme: colorScheme))
        .shadow(color: Color.black.opacity(colorScheme == .dark ? 0.4 : 0.15), radius: 5, x: 0, y: 3)
        .overlay(GlossyCardOverlay(cornerRadius: 10, colorScheme: colorScheme))
    }
}

struct GlossyCardBackground: View {
    let cornerRadius: CGFloat
    let colorScheme: ColorScheme

    var body: some View {
        if colorScheme == .dark {
            RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                .fill(
                    LinearGradient(
                        colors: [Color(white: 0.26), Color(white: 0.16)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
        } else {
            RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                .fill(
                    LinearGradient(
                        colors: [Color(white: 1.0), Color(white: 0.97)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
        }
    }
}

struct GlossyCardOverlay: View {
    let cornerRadius: CGFloat
    let colorScheme: ColorScheme

    var body: some View {
        if colorScheme == .dark {
            RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                .strokeBorder(
                    LinearGradient(
                        colors: [Color.white.opacity(0.15), Color.white.opacity(0.02)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    ),
                    lineWidth: 0.5
                )
        } else {
            RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                .strokeBorder(
                    LinearGradient(
                        colors: [
                            Color(red: 0.91, green: 0.44, blue: 0.53).opacity(0.2),
                            Color(red: 0.91, green: 0.44, blue: 0.53).opacity(0.05)
                        ],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    ),
                    lineWidth: 0.5
                )
        }
    }
}
