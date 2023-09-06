import UIKit

class ProfileView: UIView {
    private lazy var image: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = true
        return image
    }()
    
    private lazy var name: UILabel = {
        let text = UILabel()
        return text
    }()
    
    private lazy var stackList: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private func addLayout() {
        addSubview(image)
        addSubview(name)
        addSubview(stackList)
    }
    
    private func setupConstrainsts() {
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: topAnchor),
            image.centerXAnchor.constraint(equalTo: centerXAnchor),
            image.widthAnchor.constraint(equalToConstant: 40),
            image.heightAnchor.constraint(equalToConstant: 40),
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
            stackList.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackList.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    func configureProfileView(profile: ProfileViewModel) {
        name.text = profile.name
        for item in profile.characteristics {
            let itemView = ProfileInformationItem()
            itemView.configureItem(item: item)
            stackList.addArrangedSubview(itemView)
        }
    }
}
