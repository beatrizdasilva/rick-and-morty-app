import UIKit

class ProfileInformationItem: UIView {
    private lazy var stackLine: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.addArrangedSubview(leftLabel)
        stack.addArrangedSubview(rightLabel)
        stack.spacing = 8
        stack.alignment = .leading
        stack.distribution = .fill
        return stack
    }()
    
    private lazy var leftLabel: UILabel = {
        let label = UILabel()
        label.isHighlighted = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .yellow
        return label
    }()
    
    private lazy var rightLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .green
        return label
    }()
    
    private lazy var dividerView: UIView = {
        let divider = UIView()
        divider.translatesAutoresizingMaskIntoConstraints = false
        divider.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
//        divider.backgroundColor = UIColor(named: "background00") ou cmd + shift + l
        return divider
    }()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        addLayout()
        setupConstrainsts()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addLayout() {
        addSubview(stackLine)
        addSubview(dividerView)
    }
    
    private func setupConstrainsts() {
        leftLabel.setContentHuggingPriority(.required, for: .horizontal)
        rightLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)
        
        NSLayoutConstraint.activate([
            stackLine.topAnchor.constraint(equalTo: topAnchor),
            stackLine.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackLine.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            dividerView.topAnchor.constraint(equalTo: stackLine.bottomAnchor, constant: 4),
            dividerView.bottomAnchor.constraint(equalTo: bottomAnchor),
            dividerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            dividerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            dividerView.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
    
    func configureItem(item: ProfileViewModel.ListItem) {
        leftLabel.text = item.primaryText
        rightLabel.text = item.secondaryText
    }
}
