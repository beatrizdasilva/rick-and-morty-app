import UIKit

class ViewController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        tabBar.isTranslucent = false
//        tabBarController?.tabBar.isHidden = true
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
        let navigationController = UINavigationController(
            rootViewController: CharactersViewController()
        )
        navigationController.tabBarItem.title = "Character"
        navigationController.tabBarItem.image = .add
        return navigationController
    }
    
    private func createLocationItem() -> UIViewController {
        let navigationController = UINavigationController(
            rootViewController: LocationsViewController(
                viewModel: LocationsViewModel(
                    service: LocationsService()
                )
            )
        )
        navigationController.tabBarItem.title = "Location"
        navigationController.tabBarItem.image = .remove
        return navigationController
    }
    
    private func createEpisodeItem() -> UIViewController {
        let navigationController = UINavigationController(
            rootViewController: EpisodesViewController(
                viewModel: EpisodesViewModel(
                    service: EpisodesService()
                )
            )
        )
        navigationController.tabBarItem.title = "Episodes"
        navigationController.tabBarItem.image = .checkmark
        return navigationController
    }
}
