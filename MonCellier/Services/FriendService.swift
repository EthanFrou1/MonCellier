import Foundation

// Modèle pour l'API d'amis (mockée)
struct SharedTasting: Codable, Identifiable {
    let id: String
    let wineName: String
    let rating: Double
    let comment: String
    let date: Date
}

// Service pour l'API d'amis (mockée)
class FriendService {
    // Singleton
    static let shared = FriendService()
    
    private init() {}
    
    // Obtenir la liste des amis
    func getFriends() -> [Friend] {
        // Données mockées
        return [
            Friend(
                id: "1",
                name: "Sophie Durand",
                email: "sophie@example.com",
                sharedTastings: [
                    SharedTasting(
                        id: "101",
                        wineName: "Château Margaux 2015",
                        rating: 4.7,
                        comment: "Superbe équilibre, notes de cassis et de cèdre.",
                        date: Date().addingTimeInterval(-7*24*60*60) // 1 semaine
                    )
                ]
            ),
            Friend(
                id: "2",
                name: "Thomas Martin",
                email: "thomas@example.com",
                sharedTastings: [
                    SharedTasting(
                        id: "102",
                        wineName: "Puligny-Montrachet 2018",
                        rating: 4.5,
                        comment: "Arômes de noisette et de pomme verte, finale longue.",
                        date: Date().addingTimeInterval(-2*24*60*60) // 2 jours
                    ),
                    SharedTasting(
                        id: "103",
                        wineName: "Clos Vougeot 2016",
                        rating: 4.8,
                        comment: "Complexe et élégant, tanins soyeux.",
                        date: Date().addingTimeInterval(-14*24*60*60) // 2 semaines
                    )
                ]
            )
        ]
    }
    
    // Ajouter un ami
    func addFriend(name: String, email: String) -> Friend {
        // Dans une implémentation réelle, on ferait une requête API
        return Friend(id: UUID().uuidString, name: name, email: email, sharedTastings: [])
    }
    
    // Partager une dégustation avec des amis
    func shareTasting(friendIds: [String], tastingNote: TastingNote) {
        // Dans une implémentation réelle, on ferait une requête API
        print("Dégustation partagée avec \(friendIds.count) amis")
    }
}
