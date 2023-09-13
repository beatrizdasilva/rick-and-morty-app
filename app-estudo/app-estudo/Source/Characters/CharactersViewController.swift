import UI
import UIKit

class CharactersViewController: UIViewController {
    private lazy var profile: ProfileView = {
        let profile = ProfileView()
        profile.translatesAutoresizingMaskIntoConstraints = false
        profile.configureProfileView(profile: .init(
            name: "Rick",
            characteristics: [
                .init(
                    primaryText: "Status",
                    secondaryText: "Alive"
                ),
                .init(
                    primaryText: "Species",
                    secondaryText: "Human"
                )
            ]
        ))
        return profile
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addLayout()
        setupConstrainsts()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let searchController = UISearchController(searchResultsController: nil)
        self.navigationItem.searchController = searchController
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Characters"
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init code has not been implemented")
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    private func addLayout() {
        view.addSubview(profile)
    }
    
    private func setupConstrainsts() {
        NSLayoutConstraint.activate([
            profile.topAnchor.constraint(greaterThanOrEqualTo: view.topAnchor),
            profile.bottomAnchor.constraint(lessThanOrEqualTo: view.bottomAnchor),
            profile.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            profile.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            profile.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}
