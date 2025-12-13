//
//  MiluWidget.swift
//  MiluWidget
//
//  Created by aphlo on 2025/12/04.
//

import WidgetKit
import SwiftUI

struct MiluWidget: Widget {
    let kind: String = "MiluWidget"

    var body: some WidgetConfiguration {
        if #available(iOS 16.0, *) {
            return StaticConfiguration(kind: kind, provider: Provider()) { entry in
                MiluWidgetEntryView(entry: entry)
            }
            .configurationDisplayName("milu")
            .description("育児記録をすばやく確認")
            .supportedFamilies([.systemSmall, .systemMedium, .accessoryCircular])
        } else {
            return StaticConfiguration(kind: kind, provider: Provider()) { entry in
                MiluWidgetEntryView(entry: entry)
            }
            .configurationDisplayName("milu")
            .description("育児記録をすばやく確認")
            .supportedFamilies([.systemSmall, .systemMedium])
        }
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
            DisplayRecord(type: "formula", time: "14:30", elapsed: "30分前", isPlaceholder: false, isLatest: true)
        ],
        latestRecord: DisplayRecord(type: "formula", time: "14:30", elapsed: "30分前", isPlaceholder: false, isLatest: true),
        settings: .default
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
            DisplayRecord(type: "breastRight", time: "12:00", elapsed: "2時間前", isPlaceholder: false, isLatest: false),
            DisplayRecord(type: "formula", time: "14:30", elapsed: "30分前", isPlaceholder: false, isLatest: true),
            DisplayRecord(type: "pee", time: "13:45", elapsed: "1時間前", isPlaceholder: false, isLatest: false)
        ],
        latestRecord: DisplayRecord(type: "formula", time: "14:30", elapsed: "30分前", isPlaceholder: false, isLatest: true),
        settings: .default
    )
}
