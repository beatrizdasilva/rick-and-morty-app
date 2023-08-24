import UI
import UIKit

protocol EpisodesViewControllerDisplay: AnyObject {
    func reloadEpisodes(episode: [InformationViewModel], isLoadAllInformation: Bool)
}

class EpisodesViewController: UIViewController, UITableViewDelegate, EpisodesViewControllerDisplay {
    private var viewModel: EpisodesViewModelProtocol
    private var isLoadAllInformation: Bool = true
    
    private lazy var table: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.rowHeight = UITableView.automaticDimension
        table.estimatedRowHeight = 30
        table.register(
            InformationUITableViewCell.self,
            forCellReuseIdentifier: String(describing: InformationUITableViewCell.self)
        )
        table.register(
            LoadingUITableView.self,
            forCellReuseIdentifier: String(describing: LoadingUITableView.self)
        )
        table.contentInset.bottom = tabBarController?.tabBar.frame.height ?? 0
        table.dataSource = self
        table.delegate = self
        table.refreshControl = refreshControl
        table.separatorStyle = .none
        return table
    }()
    
    private lazy var refreshControl: UIRefreshControl = {
        let rc = UIRefreshControl()
        rc.attributedTitle = NSAttributedString(string: "Atualizando")
        rc.addTarget(self, action: #selector(refreshView), for: .valueChanged)
        return rc
    }()
    
    var informations: [InformationViewModel] = [] {
        didSet {
            refreshControl.endRefreshing()
        }
    }
    
    func reloadEpisodes(episode: [InformationViewModel], isLoadAllInformation: Bool) {
        self.isLoadAllInformation = isLoadAllInformation
        self.informations = episode
        table.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addLayout()
        setupConstrainsts()
        viewModel.loadEpisodes()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        self.navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Episodes"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationItem.hidesSearchBarWhenScrolling = true
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init code has not been implemented")
    }
    
    init(viewModel: EpisodesViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.viewModel.display = self
        addLayout()
        setupConstrainsts()
    }
    
    private func addLayout() {
        view.addSubview(table)
    }
    
    private func setupConstrainsts() {
        NSLayoutConstraint.activate([
            table.topAnchor.constraint(equalTo: view.topAnchor),
            table.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            table.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            table.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    @objc
    func refreshView() {
        viewModel.loadEpisodes()
    }
}

extension EpisodesViewController: UITableViewDataSource {
    enum TableSection: Int {
        case episodes
        case loader
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let currentSection = TableSection(rawValue: section) else { return 0 }
        switch currentSection {
        case .episodes:
            return informations.count
        case .loader:
            return isLoadAllInformation ? 0 : 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let currentSection = TableSection(rawValue: indexPath.section) else { return UITableViewCell() }
        
        switch currentSection {
        case .episodes:
            guard let cell: InformationUITableViewCell = tableView.dequeueReusableCell(
                withIdentifier: String(describing: InformationUITableViewCell.self),
                for: indexPath
            ) as? InformationUITableViewCell else { return UITableViewCell() }
            
            let informationViewModel = informations[indexPath.row]
            
            cell.configureView(informationViewModel: informationViewModel)
            
            return cell
        case .loader:
            guard let cell: LoadingUITableView = tableView.dequeueReusableCell(
                withIdentifier: String(describing: LoadingUITableView.self),
                for: indexPath
            ) as? LoadingUITableView else { return UITableViewCell() }
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == informations.count - 1 {
            viewModel.getNextEpisodes()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
}

extension EpisodesViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchText = searchController.searchBar.text
        viewModel.searchEpisode(name: searchText ?? "")
    }
}
