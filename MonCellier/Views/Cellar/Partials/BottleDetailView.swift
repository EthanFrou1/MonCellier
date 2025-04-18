import SwiftUI

struct BottleDetailView: View {
    let bottle: Bottle
    let viewModel: CellarViewModel
    @State private var quantity: Int16
    @Environment(\.presentationMode) var presentationMode

    init(bottle: Bottle, viewModel: CellarViewModel) {
        self.bottle = bottle
        self.viewModel = viewModel
        _quantity = State(initialValue: bottle.quantity)
    }

    var body: some View {
        NavigationView {
            Form {
                bottleInfoSection
                stockSection
                tastingNotesSection
            }
            .navigationTitle("Détails")
            .navigationBarItems(trailing: Button("Fermer") {
                presentationMode.wrappedValue.dismiss()
            })
        }
    }

    private var bottleInfoSection: some View {
        Section(header: Text("Informations")) {
            VStack(alignment: .center, spacing: 10) {
                ZStack {
                    Circle()
                        .fill(wineTypeColor(bottle.type ?? "autre"))
                        .frame(width: 80, height: 80)

                    Image(systemName: "wineglass")
                        .font(.system(size: 40))
                        .foregroundColor(.white)
                }
                .padding(.top, 10)

                Text(bottle.name ?? "")
                    .font(.title)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 5)

                HStack {
                    VStack {
                        Text("Année")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        Text("\(bottle.year)")
                            .font(.headline)
                    }

                    Divider()
                        .frame(height: 30)

                    VStack {
                        Text("Type")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        Text(bottle.type ?? "")
                            .font(.headline)
                    }

                    if let region = bottle.region {
                        Divider()
                            .frame(height: 30)

                        VStack {
                            Text("Région")
                                .font(.caption)
                                .foregroundColor(.secondary)
                            Text(region)
                                .font(.headline)
                        }
                    }
                }
                .padding(.bottom, 5)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical)

            if let grape = bottle.grape {
                infoRow(label: "Cépage", value: grape)
            }

            infoRow(label: "Prix", value: String(format: "%.2f €", bottle.price))

            if let purchaseLocation = bottle.purchaseLocation {
                infoRow(label: "Lieu d'achat", value: purchaseLocation)
            }

            if let dateAdded = bottle.dateAdded {
                infoRow(label: "Date d'ajout", value: dateFormatter.string(from: dateAdded))
            }
        }
    }

    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter
    }()

    private func wineTypeColor(_ type: String) -> Color {
        switch type.lowercased() {
        case "rouge": return .red
        case "blanc": return Color(red: 0.9, green: 0.9, blue: 0.6)
        case "rosé": return Color(red: 0.9, green: 0.7, blue: 0.7)
        case "champagne": return Color(red: 0.9, green: 0.85, blue: 0.6)
        case "mousseux": return Color(red: 0.8, green: 0.8, blue: 0.8)
        default: return Color.blue
        }
    }

    private var stockSection: some View {
        Section(header: Text("Stock")) {
            Stepper("Quantité: \(quantity)", value: $quantity, in: 0...100)

            Button(action: {
                viewModel.updateBottleQuantity(bottle: bottle, newQuantity: quantity)
                presentationMode.wrappedValue.dismiss()
            }) {
                Text("Mettre à jour")
                    .foregroundColor(.blue)
            }

            Button(action: {
                viewModel.markBottleAsConsumed(bottle: bottle)
            }) {
                Text("Marquer comme consommée")
                    .fontWeight(.semibold)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(bottle.isConsumed ? Color.gray.opacity(0.3) : Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .disabled(bottle.isConsumed)
        }
    }

    private var tastingNotesSection: some View {
        Section(header: Text("Dégustations")) {
            let notes = (bottle.notes as? Set<TastingNote>)?.sorted(by: {
                ($0.date ?? .distantPast) > ($1.date ?? .distantPast)
            }) ?? []

            if notes.isEmpty {
                Text("Aucune dégustation enregistrée")
                    .foregroundColor(.secondary)
            } else {
                ForEach(notes, id: \.id) { note in
                    VStack(alignment: .leading) {
                        HStack {
                            ForEach(0..<5) { i in
                                Image(systemName: i < Int(note.rating) ? "star.fill" : "star")
                                    .foregroundColor(.yellow)
                                    .font(.caption)
                            }

                            Spacer()

                            Text(note.date ?? Date(), style: .date)
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }

                        if let comment = note.comment, !comment.isEmpty {
                            Text(comment)
                                .font(.body)
                                .padding(.top, 4)
                        }

                        if let pairing = note.pairing, !pairing.isEmpty {
                            Text("Accord: \(pairing)")
                                .font(.caption)
                                .foregroundColor(.secondary)
                                .padding(.top, 2)
                        }
                    }
                    .padding(.vertical, 4)
                }
            }

            NavigationLink(destination: TastingFormView(selectedTab: .constant(0), bottle: bottle)) {
                Text("Ajouter une dégustation")
            }
        }
    }

    private func infoRow(label: String, value: String) -> some View {
        HStack {
            Text(label)
            Spacer()
            Text(value)
                .foregroundColor(.secondary)
        }
    }
}
