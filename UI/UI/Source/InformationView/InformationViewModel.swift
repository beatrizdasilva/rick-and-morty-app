import UIKit
public struct InformationViewModel {
    public let id: Int
    public var image: UIImage?
    let title: String
    let primaryText: String
    let secondaryText: String?
    
    public init(id: Int, image: UIImage?, title: String, primaryText: String, secondaryText: String?) {
        self.id = id
        self.image = image
        self.title = title
        self.primaryText = primaryText
        self.secondaryText = secondaryText
    }
    
    func isSecondaryTextHidden() -> Bool {
        secondaryText == nil
    }
}
