public struct InformationViewModel {
    let title: String
    let primaryText: String
    let secondaryText: String?
    
    public init(title: String, primaryText: String, secondaryText: String?) {
        self.title = title
        self.primaryText = primaryText
        self.secondaryText = secondaryText
    }
    
    func isSecondaryTextHidden() -> Bool {
        secondaryText == nil
    }
}
