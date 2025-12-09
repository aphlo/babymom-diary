import SwiftUI

// MARK: - Color Definitions

struct WidgetColors {
    // Light mode colors
    static let lightBackground = Color(red: 0.961, green: 0.961, blue: 0.961) // #F5F5F5
    static let lightCardBackground = Color(red: 1.0, green: 1.0, blue: 1.0) // #FFFFFF
    static let lightCardBorder = Color(red: 0.91, green: 0.44, blue: 0.53) // #E87086
    static let lightHeaderBackground = Color(red: 1.0, green: 0.941, blue: 0.949) // #FFF0F2
    static let lightTextPrimary = Color(red: 0.129, green: 0.129, blue: 0.129) // #212121
    static let lightTextSecondary = Color(red: 0.459, green: 0.459, blue: 0.459) // #757575
    static let lightTextTime = Color(red: 0.91, green: 0.44, blue: 0.53) // #E87086
    static let lightTextAgo = Color(red: 0.259, green: 0.259, blue: 0.259) // #424242

    // Dark mode colors
    static let darkBackground = Color(red: 0.11, green: 0.11, blue: 0.118) // #1C1C1E
    static let darkCardBackground = Color(red: 0.173, green: 0.173, blue: 0.18) // #2C2C2E
    static let darkCardBorder = Color.clear // Transparent
    static let darkHeaderBackground = Color(red: 0.239, green: 0.165, blue: 0.188) // #3D2A30
    static let darkTextPrimary = Color(red: 1.0, green: 1.0, blue: 1.0) // #FFFFFF
    static let darkTextSecondary = Color(red: 0.69, green: 0.69, blue: 0.69) // #B0B0B0
    static let darkTextTime = Color(red: 1.0, green: 0.541, blue: 0.62) // #FF8A9E
    static let darkTextAgo = Color(red: 0.878, green: 0.878, blue: 0.878) // #E0E0E0

    static func background(for colorScheme: ColorScheme) -> Color {
        colorScheme == .dark ? darkBackground : lightBackground
    }

    static func cardBackground(for colorScheme: ColorScheme) -> Color {
        colorScheme == .dark ? darkCardBackground : lightCardBackground
    }

    static func cardBorder(for colorScheme: ColorScheme) -> Color {
        colorScheme == .dark ? darkCardBorder : lightCardBorder
    }

    static func textPrimary(for colorScheme: ColorScheme) -> Color {
        colorScheme == .dark ? darkTextPrimary : lightTextPrimary
    }

    static func textSecondary(for colorScheme: ColorScheme) -> Color {
        colorScheme == .dark ? darkTextSecondary : lightTextSecondary
    }

    static func textTime(for colorScheme: ColorScheme) -> Color {
        colorScheme == .dark ? darkTextTime : lightTextTime
    }

    static func textAgo(for colorScheme: ColorScheme) -> Color {
        colorScheme == .dark ? darkTextAgo : lightTextAgo
    }

    static func headerBackground(for colorScheme: ColorScheme) -> Color {
        colorScheme == .dark ? darkHeaderBackground : lightHeaderBackground
    }
}
