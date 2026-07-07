import SwiftUI

/// fresh new-growth green on deep forest
enum Theme {
    static let accent = Color(red: 0.1843, green: 0.5608, blue: 0.3569)
    static let accentSecondary = Color(red: 0.1137, green: 0.2941, blue: 0.2000)
    static let background = Color(red: 0.0706, green: 0.1294, blue: 0.1020)
    static let cardBackground = background.opacity(0.6)

    static let titleFont = Font.system(.title2, design: .rounded).weight(.bold)
    static let headlineFont = Font.system(.headline, design: .rounded)
    static let bodyFont = Font.system(.body, design: .rounded)
    static let captionFont = Font.system(.caption, design: .rounded)

    static let cornerRadius: CGFloat = 16
}
