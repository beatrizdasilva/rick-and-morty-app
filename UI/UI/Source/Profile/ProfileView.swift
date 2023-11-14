import UIKit

public class ProfileView: UIView {
    private lazy var image: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.backgroundColor = .blue
        return image
    }()
    
    private lazy var name: UILabel = {
        let text = UILabel()
        text.textAlignment = .center
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    private lazy var stackList: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fill
        stack.alignment = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private func addLayout() {
        addSubview(image)
        addSubview(name)
        addSubview(stackList)
        backgroundColor = .red
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        addLayout()
        setupConstrainsts()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstrainsts() {
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: topAnchor),
            image.centerXAnchor.constraint(equalTo: centerXAnchor),
            image.widthAnchor.constraint(equalToConstant: 150),
            image.heightAnchor.constraint(equalToConstant: 150),
            image.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor),
            image.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            name.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 8),
            name.leadingAnchor.constraint(equalTo: leadingAnchor),
            name.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            stackList.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 16),
            stackList.bottomAnchor.constraint(equalTo: bottomAnchor),
            stackList.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            stackList.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])
    }
    
    public func configureProfileView(profile: ProfileViewModel) {
        name.text = profile.name
        for item in stackList.arrangedSubviews {
            stackList.removeArrangedSubview(item)
            item.removeFromSuperview()
        }
                
        for item in profile.characteristics {
            let itemView = ProfileInformationItem()
            itemView.configureItem(item: item)
            stackList.addArrangedSubview(itemView)
        }
    }
}
