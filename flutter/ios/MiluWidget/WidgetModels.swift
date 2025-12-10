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

struct MediumWidgetSettings: Codable {
    let displayRecordTypes: [String]
    let quickActionTypes: [String]

    static let `default` = MediumWidgetSettings(
        displayRecordTypes: ["breast", "formula", "pee"],
        quickActionTypes: ["breastLeft", "formula", "pee", "poop", "temperature"]
    )
}

struct SmallWidgetSettings: Codable {
    let filterRecordType: String?

    static let `default` = SmallWidgetSettings(filterRecordType: nil)
}

struct WidgetSettings: Codable {
    let mediumWidget: MediumWidgetSettings
    let smallWidget: SmallWidgetSettings

    static let `default` = WidgetSettings(
        mediumWidget: .default,
        smallWidget: .default
    )
}

struct WidgetData: Codable {
    let lastUpdated: String?
    let selectedChildId: String?
    let children: [WidgetChild]?
    let recentRecords: [String: [WidgetRecord]]?
}

// MARK: - Display Models

struct DisplayRecord {
    let type: String
    let time: String
    let elapsed: String
    let isPlaceholder: Bool

    var emoji: String {
        switch type {
        case "breastLeft", "breastRight":
            return "🤱"
        case "breast":
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

    var displayName: String {
        switch type {
        case "breastLeft":
            return "授乳(左)"
        case "breastRight":
            return "授乳(右)"
        case "breast":
            return "授乳"
        case "formula":
            return "ミルク"
        case "pee":
            return "尿"
        case "poop":
            return "便"
        case "temperature":
            return "体温"
        case "pump":
            return "搾母乳"
        default:
            return "その他"
        }
    }
}

// MARK: - Entry

struct WidgetEntry: TimelineEntry {
    let date: Date
    let childName: String
    let childAge: String
    let records: [DisplayRecord]
    let settings: WidgetSettings
}
