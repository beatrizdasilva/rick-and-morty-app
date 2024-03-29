import UIKit

public class InformationView: UIView {
    private var size: CGFloat = 40
    
    private lazy var image: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var title: UILabel = {
        let text = UILabel()
        text.font = .boldSystemFont(ofSize: 17)
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
        stack.spacing = 10
        stack.distribution = .fill
        return stack
    }()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        addLayout()
        setupConstrainsts()
    }
    
    public convenience init(imageSize: CGFloat) {
        self.init(frame: .zero)
        self.size = imageSize
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
            textStack.topAnchor.constraint(equalTo: topAnchor, constant: 8)
        ])
        
        NSLayoutConstraint.activate([
            image.widthAnchor.constraint(equalToConstant: size),
            image.heightAnchor.constraint(equalToConstant: size)
        ])
    }
    
    public func configureView(informationViewModel: InformationViewModel) {
        image.image = informationViewModel.image
        title.text = informationViewModel.title
        primaryText.text = informationViewModel.primaryText
        secondaryText.text = informationViewModel.secondaryText
        secondaryText.isHidden = informationViewModel.isSecondaryTextHidden()
    }
}
