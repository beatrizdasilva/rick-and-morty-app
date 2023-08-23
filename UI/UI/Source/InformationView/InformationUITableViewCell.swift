import UIKit

public class InformationUITableViewCell: UITableViewCell {
    private lazy var informationView: InformationView = {
        let informationView = InformationView()
        informationView.translatesAutoresizingMaskIntoConstraints = false
        return informationView
    }()
    
    private lazy var dividerView: UIView = {
        let divider = UIView()
        divider.translatesAutoresizingMaskIntoConstraints = false
        divider.backgroundColor = #colorLiteral(red: 0.7574376578, green: 0.7574376578, blue: 0.7574376578, alpha: 1)
//        divider.backgroundColor = UIColor(named: "background00") ou cmd + shift + l
        return divider
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
        contentView.addSubview(dividerView)
    }
    
    private func setupConstrainsts() {
        NSLayoutConstraint.activate([
            informationView.topAnchor.constraint(equalTo: contentView.topAnchor),
            informationView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            informationView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20)
        ])
        
        NSLayoutConstraint.activate([
            dividerView.topAnchor.constraint(equalTo: informationView.bottomAnchor, constant: 4),
            dividerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            dividerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            dividerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            dividerView.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
    
    public func configureView(informationViewModel: InformationViewModel) {
        informationView.configureView(informationViewModel: informationViewModel)
    }
}
