import UIKit

public class InformationView: UIView {
    private lazy var image: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        image.backgroundColor = .cyan
        return image
    }()
    
    private lazy var title: UILabel = {
        let text = UILabel()
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    private lazy var primaryText: UILabel = {
        let text = UILabel()
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    private lazy var secondaryText: UILabel = {
        let text = UILabel()
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    private lazy var textStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.alignment = .leading
        stack.axis = .vertical
        stack.distribution = .fill
        return stack
    }()
    
    private lazy var stack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.alignment = .center
        stack.axis = .horizontal
        stack.distribution = .fill
        return stack
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
        addSubview(stack)
        stack.addArrangedSubview(image)
        stack.addArrangedSubview(textStack)
        textStack.addArrangedSubview(title)
        textStack.addArrangedSubview(primaryText)
        textStack.addArrangedSubview(secondaryText)
    }
    
    private func setupConstrainsts() {
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: topAnchor),
            stack.bottomAnchor.constraint(equalTo: bottomAnchor),
            stack.leadingAnchor.constraint(equalTo: leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            image.widthAnchor.constraint(equalToConstant: 30),
            image.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    public func configureView(informationViewModel: InformationViewModel) {
        title.text = informationViewModel.title
        primaryText.text = informationViewModel.primaryText
        secondaryText.text = informationViewModel.secondaryText
        secondaryText.isHidden = informationViewModel.isSecondaryTextHidden()
    }
}
