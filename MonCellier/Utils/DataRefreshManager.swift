import SwiftUI
import Combine

class DataRefreshManager: ObservableObject {
    @Published var bottleRefreshTrigger = UUID()
    @Published var tastingRefreshTrigger = UUID()
    @Published var profileRefreshTrigger = UUID()
    @Published var friendsRefreshTrigger = UUID()

    static let shared = DataRefreshManager()

    func refreshBottleData() {
        bottleRefreshTrigger = UUID()
    }

    func refreshTastingData() {
        tastingRefreshTrigger = UUID()
    }

    func refreshProfileData() {
        profileRefreshTrigger = UUID()
    }

    func refreshFriends() {
        friendsRefreshTrigger = UUID()
    }

    func refreshAllData() {
        bottleRefreshTrigger = UUID()
        tastingRefreshTrigger = UUID()
        profileRefreshTrigger = UUID()
        friendsRefreshTrigger = UUID()
    }
}
