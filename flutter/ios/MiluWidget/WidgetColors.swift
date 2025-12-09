import SwiftUI

// MARK: - Color Definitions

struct WidgetColors {
    // Light mode colors
    static let lightBackground = Color(red: 0.98, green: 0.98, blue: 0.98) // #FAFAFA
    static let lightCardBackground = Color(red: 1.0, green: 1.0, blue: 1.0) // #FFFFFF
    static let lightCardBorder = Color(red: 0.91, green: 0.44, blue: 0.53) // #E87086
    static let lightHeaderBackground = Color(red: 1.0, green: 0.941, blue: 0.949) // #FFF0F2
    static let lightTextPrimary = Color(red: 0.1, green: 0.1, blue: 0.1) // #1A1A1A
    static let lightTextSecondary = Color(red: 0.5, green: 0.5, blue: 0.5) // #808080
    static let lightTextTime = Color(red: 0.91, green: 0.44, blue: 0.53) // #E87086
    static let lightTextAgo = Color(red: 0.3, green: 0.3, blue: 0.3) // #4D4D4D

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
