// Couleurs et thème global à ajouter dans un fichier "Theme.swift"
import SwiftUI

struct AppTheme {
    // Palette de couleurs principale
    static let primary = Color.purple
    static let secondary = Color(red: 0.55, green: 0.0, blue: 0.7) // Violet plus foncé
    static let accent = Color(red: 0.85, green: 0.1, blue: 0.3) // Rouge bordeaux
    
    // Couleurs par type de vin
    static func wineTypeColor(_ type: String) -> Color {
        switch type.lowercased() {
        case "rouge":
            return Color(red: 0.85, green: 0.1, blue: 0.3) // Rouge bordeaux
        case "blanc":
            return Color(red: 0.95, green: 0.9, blue: 0.5) // Jaune pâle
        case "rosé":
            return Color(red: 0.95, green: 0.7, blue: 0.75) // Rose pâle
        case "champagne", "mousseux":
            return Color(red: 0.95, green: 0.85, blue: 0.5) // Doré
        default:
            return Color.purple
        }
    }
    
    // Styles de texte
    static let titleFont = Font.system(size: 28, weight: .bold, design: .rounded)
    static let headingFont = Font.system(size: 22, weight: .bold, design: .rounded)
    static let subheadingFont = Font.system(size: 18, weight: .semibold, design: .rounded)
    static let bodyFont = Font.system(size: 16, weight: .regular)
    
    // Styles de bouton
    static var primaryButtonStyle: some ButtonStyle {
        return PrimaryButtonStyle()
    }
    
    // Styles de carte
    static var cardStyle: some ViewModifier {
        return CardModifier()
    }
}

struct PrimaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(AppTheme.primary)
            .foregroundColor(.white)
            .cornerRadius(10)
            .scaleEffect(configuration.isPressed ? 0.98 : 1)
            .shadow(color: Color.black.opacity(0.2), radius: 2, x: 0, y: configuration.isPressed ? 1 : 2)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
}

struct CardModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .background(Color(.systemBackground))
            .cornerRadius(12)
            .shadow(color: Color.black.opacity(0.15), radius: 5, x: 0, y: 2)
    }
}

// Extensions utiles
extension View {
    func cardStyle() -> some View {
        modifier(AppTheme.cardStyle)
    }
}
