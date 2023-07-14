import UI
import UIKit

protocol LocationsViewControllerDisplay: AnyObject {
    var informations: [InformationViewModel] { get set }
}

class LocationsViewController: UIViewController, UITableViewDelegate, LocationsViewControllerDisplay {
    private var viewModel: LocationsViewModelProtocol
    
    private lazy var table: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.rowHeight = UITableView.automaticDimension
        table.estimatedRowHeight = 30
        table.register(
            InformationUITableViewCell.self,
            forCellReuseIdentifier: String(describing: InformationUITableViewCell.self)
        )
        table.dataSource = self
        table.delegate = self
        return table
    }()
    
    var informations: [InformationViewModel] = [] {
        didSet {
            table.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .orange
        viewModel.loadLocations()
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
}

extension LocationsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        informations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: InformationUITableViewCell = tableView.dequeueReusableCell(
            withIdentifier: String(describing: InformationUITableViewCell.self),
            for: indexPath
        ) as? InformationUITableViewCell else { return UITableViewCell() }
        
        let informationViewModel = informations[indexPath.row]
        
        cell.configureView(informationViewModel: informationViewModel)
        
        return cell
    }
}
