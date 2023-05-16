import UIKit

class ViewController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.isTranslucent = false
        viewControllers = [createCharacterItem(), createLocationItem(), createEpisodeItem()]
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init code has not been implemented")
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    private func createCharacterItem() -> UIViewController {
        let navigationController = UINavigationController(rootViewController: CharactersViewController())
        navigationController.tabBarItem.title = "Character"
        navigationController.tabBarItem.image = .add
        return navigationController
    }
    
    private func createEpisodeItem() -> UIViewController {
        let navigationController = UINavigationController(rootViewController: EpisodesViewController())
        navigationController.tabBarItem.title = "Episodes"
        navigationController.tabBarItem.image = .checkmark
        return navigationController
    }

    private func createLocationItem() -> UIViewController {
        let navigationController = UINavigationController(rootViewController: LocationsViewController())
        navigationController.tabBarItem.title = "Location"
        navigationController.tabBarItem.image = .remove
        return navigationController
    }
}
