import SwiftUI

struct BottleRow: View {
    @ObservedObject var bottle: Bottle
    
    var body: some View {
        HStack(spacing: 12) {
            // Icône de la bouteille avec couleur selon le type
            ZStack {
                Circle()
                    .fill(wineTypeColor(bottle.type ?? "autre"))
                    .frame(width: 50, height: 50)
                
                Image(systemName: "wineglass")
                    .font(.system(size: 24))
                    .foregroundColor(.white)
            }
            .accessibilityHidden(true) // Cacher l'image décorative pour les lecteurs d'écran
            
            VStack(alignment: .leading, spacing: 4) {
                Text(bottle.name ?? "autre")
                    .font(.headline)
                    .lineLimit(1)
                
                Text("\(bottle.year)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                if let region = bottle.region {
                    Text(region)
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                
                if let grape = bottle.grape {
                    Text(grape)
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
            
            Spacer()
            
            VStack(alignment: .trailing) {
                Text("\(bottle.quantity)")
                    .font(.title3)
                    .fontWeight(.bold)
                
                Text(bottle.quantity == 1 ? "bouteille" : "bouteilles")
                    .font(.caption)
                    .foregroundColor(.secondary)
                
                Text(String(format: "%.2f €", bottle.price))
                    .font(.caption)
            }
        }
        .padding(.vertical, 8)
        .accessibilityElement(children: .combine)
        .accessibilityLabel("Vin \(bottle.name ?? "Inconnu"), \(bottle.year), \(bottle.type ?? ""), \(bottle.quantity) bouteilles, \(String(format: "%.2f euros", bottle.price))")
    }
    
    // Fonction pour déterminer la couleur en fonction du type de vin
    private func wineTypeColor(_ type: String) -> Color {
        switch type.lowercased() {
        case "rouge":
            return .red
        case "blanc":
            return Color(red: 0.9, green: 0.9, blue: 0.6)
        case "rosé":
            return Color(red: 0.9, green: 0.7, blue: 0.7)
        case "champagne":
            return Color(red: 0.9, green: 0.85, blue: 0.6)
        case "mousseux":
            return Color(red: 0.8, green: 0.8, blue: 0.8)
        default:
            return Color.blue
        }
    }
}
