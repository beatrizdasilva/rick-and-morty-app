import UIKit

class ProfileInformationItem: UIView {
    private lazy var stackLine: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.addArrangedSubview(leftLabel)
        stack.addArrangedSubview(rightLabel)
        return stack
    }()
    
    private lazy var leftLabel: UILabel = {
        let label = UILabel()
        label.isHighlighted = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var rightLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var dividerView: UIView = {
        let divider = UIView()
        divider.translatesAutoresizingMaskIntoConstraints = false
        divider.backgroundColor = #colorLiteral(red: 0.7574376578, green: 0.7574376578, blue: 0.7574376578, alpha: 1)
//        divider.backgroundColor = UIColor(named: "background00") ou cmd + shift + l
        return divider
    }()
    
    private func addLayout() {
        addSubview(stackLine)
        addSubview(dividerView)
    }
    
    private func setupConstrainsts() {
        NSLayoutConstraint.activate([
            stackLine.topAnchor.constraint(equalTo: topAnchor),
            stackLine.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor),
            stackLine.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            dividerView.topAnchor.constraint(equalTo: stackLine.bottomAnchor, constant: 4),
            dividerView.bottomAnchor.constraint(equalTo: bottomAnchor),
            dividerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            dividerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            dividerView.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
    
    func configureItem(item: ProfileViewModel.ListItem) {
        leftLabel.text = item.primaryText
        rightLabel.text = item.secondaryText
    }
}
