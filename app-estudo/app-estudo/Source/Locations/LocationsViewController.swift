import UI
import UIKit

class LocationsViewController: UIViewController, UITableViewDelegate {
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .orange
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init code has not been implemented")
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
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
        10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: InformationUITableViewCell = tableView.dequeueReusableCell(
            withIdentifier: String(describing: InformationUITableViewCell.self),
            for: indexPath
        ) as? InformationUITableViewCell else { return UITableViewCell() }
        
        cell.configureView(informationViewModel: InformationViewModel(
            title: "title \(indexPath.row)",
            primaryText: "primary text",
            secondaryText: "secondary text")
        )
        return cell
    }
}
