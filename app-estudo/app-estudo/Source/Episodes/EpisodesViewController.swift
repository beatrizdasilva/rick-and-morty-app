import UIKit

class EpisodesViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let searchController = UISearchController(searchResultsController: nil)
        self.navigationItem.searchController = searchController
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Episodes"
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init code has not been implemented")
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
}
