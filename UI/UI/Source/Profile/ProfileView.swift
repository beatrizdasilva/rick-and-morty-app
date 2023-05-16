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
    
    private func addLayout() {
        addSubview(image)
        addSubview(name)
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
            name.trailingAnchor.constraint(equalTo: trailingAnchor),
            name.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
