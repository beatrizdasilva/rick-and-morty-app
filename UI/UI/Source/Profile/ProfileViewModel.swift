import UIKit

public struct ProfileViewModel {
    public let image: URL?
    public let name: String
    public let characteristics: [ListItem]
}

extension ProfileViewModel {
    public struct ListItem {
        public let primaryText: String
        public let secondaryText: String
    }
}
