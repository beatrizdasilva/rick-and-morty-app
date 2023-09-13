import UI
import UIKit

protocol LocationsViewControllerDisplay: AnyObject {
    func reloadLocations(location: [InformationViewModel], isLoadAllInformation: Bool)
}

class LocationsViewController: UIViewController, UITableViewDelegate, LocationsViewControllerDisplay {
    private var viewModel: LocationsViewModelProtocol
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
        rc.attributedTitle = NSAttributedString(string: "Loading")
        rc.addTarget(self, action: #selector(refreshView), for: .valueChanged)
        return rc
    }()
    
    var informations: [InformationViewModel] = [] {
        didSet {
            refreshControl.endRefreshing()
        }
    }
    
    func reloadLocations(location: [InformationViewModel], isLoadAllInformation: Bool) {
        self.isLoadAllInformation = isLoadAllInformation
        self.informations = location
        table.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addLayout()
        setupConstrainsts()
        viewModel.loadLocations()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        self.navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Locations"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationItem.hidesSearchBarWhenScrolling = true
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init code has not been implemented")
    }
    
    init(viewModel: LocationsViewModelProtocol) {
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
        viewModel.loadLocations()
    }
}

extension LocationsViewController: UITableViewDataSource {
    enum TableSection: Int {
        case locations
        case loader
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let currentSection = TableSection(rawValue: section) else { return 0 }
        switch currentSection {
        case .locations:
            return informations.count
        case .loader:
            return isLoadAllInformation ? 0 : 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let currentSection = TableSection(rawValue: indexPath.section) else { return UITableViewCell() }
        
        switch currentSection {
        case .locations:
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
            viewModel.getNextLocations()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
}

extension LocationsViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchText = searchController.searchBar.text
        viewModel.searchLocation(name: searchText ?? "")
    }
}
