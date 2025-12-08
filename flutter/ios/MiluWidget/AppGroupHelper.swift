import Foundation

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
            return nil
        }
    }

    static func loadWidgetSettings() -> WidgetSettings {
        guard let userDefaults = UserDefaults(suiteName: appGroupId) else {
            return .default
        }

        guard let jsonString = userDefaults.string(forKey: "widget_settings"),
              let data = jsonString.data(using: .utf8) else {
            return .default
        }

        do {
            return try JSONDecoder().decode(WidgetSettings.self, from: data)
        } catch {
            print("Failed to decode widget settings: \(error)")
            return .default
        }
    }
}
