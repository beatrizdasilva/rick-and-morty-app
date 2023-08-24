import UIKit

class CharactersViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
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
}
