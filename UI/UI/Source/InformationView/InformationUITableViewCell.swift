import UIKit

public class InformationUITableViewCell: UITableViewCell {
    private lazy var informationView: InformationView = {
        let informationView = InformationView()
        informationView.translatesAutoresizingMaskIntoConstraints = false
        return informationView
    }()
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addLayout()
        setupConstrainsts()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addLayout() {
        contentView.addSubview(informationView)
    }
    
    private func setupConstrainsts() {
        NSLayoutConstraint.activate([
            informationView.topAnchor.constraint(equalTo: contentView.topAnchor),
            informationView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            informationView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            informationView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }
    
    public func configureView(informationViewModel: InformationViewModel) {
        informationView.configureView(informationViewModel: informationViewModel)
    }
}
