import UIKit

public struct ProfileViewModel {
    public let image: URL?
    public let name: String
    public let characteristics: [ListItem]
    
    public init(image: URL? = nil, name: String, characteristics: [ProfileViewModel.ListItem]) {
        self.image = image
        self.name = name
        self.characteristics = characteristics
    }
}

extension ProfileViewModel {
    public struct ListItem {
        public let primaryText: String
        public let secondaryText: String
        
        public init(primaryText: String, secondaryText: String) {
            self.primaryText = primaryText
            self.secondaryText = secondaryText
        }
    }
}
