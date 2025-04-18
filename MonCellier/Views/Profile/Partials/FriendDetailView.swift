import SwiftUI

struct FriendDetailView: View {
    let friend: FriendDTO
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel: ProfileViewModel

    var body: some View {
        List {
            Section(header: Text("Informations")) {
                Text("Nom: \(friend.name)")
                if let email = friend.email {
                    Text("Email: \(email)")
                }
            }

            Section(header: Text("Dégustations partagées")) {
                if friend.sharedTastings.isEmpty {
                    Text("Aucune dégustation partagée")
                        .foregroundColor(.secondary)
                } else {
                    ForEach(friend.sharedTastings.sorted(by: { $0.date > $1.date }), id: \.id) { tasting in
                        VStack(alignment: .leading, spacing: 5) {
                            Text(tasting.wineName)
                                .font(.headline)

                            HStack {
                                ForEach(0..<5) { i in
                                    Image(systemName: i < Int(tasting.rating) ? "star.fill" : "star")
                                        .foregroundColor(.yellow)
                                        .font(.caption)
                                }

                                Text(String(format: "%.1f", tasting.rating))
                                    .font(.caption)
                                    .padding(.leading, 5)

                                Spacer()

                                Text(tasting.date, style: .date)
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }

                            if !tasting.comment.isEmpty {
                                Text(tasting.comment)
                                    .font(.body)
                                    .padding(.top, 2)
                            }
                        }
                        .padding(.vertical, 5)
                    }
                }
            }

            Section {
                Button(role: .destructive) {
                    viewModel.removeFriend(friend)
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Label("Supprimer l'ami", systemImage: "trash")
                        .foregroundColor(.red)
                }
            }
        }
        .navigationTitle(friend.name)
    }
}
