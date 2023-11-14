import UIKit

public class ProfileUICollectionViewCell: UICollectionViewCell {    
    private lazy var profileView: ProfileView = {
        let profileView = ProfileView()
        profileView.translatesAutoresizingMaskIntoConstraints = false
        return profileView
    }()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        addLayout()
        setupConstrainsts()
        contentView.backgroundColor = .cyan
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addLayout() {
        contentView.addSubview(profileView)
    }
    
    private func setupConstrainsts() {
        NSLayoutConstraint.activate([
            profileView.topAnchor.constraint(greaterThanOrEqualTo: contentView.topAnchor),
            profileView.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor),
            profileView.leadingAnchor.constraint(greaterThanOrEqualTo: contentView.leadingAnchor),
            profileView.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor),
            profileView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            profileView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
    
    public func configureView(profileViewModel: ProfileViewModel) {
        profileView.configureProfileView(profile: profileViewModel)
    }
}

