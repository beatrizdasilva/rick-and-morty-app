import UIKit

public class LoadingView: UIView {
    private lazy var loading: UIActivityIndicatorView = {
        let loading = UIActivityIndicatorView(style: .medium)
        loading.translatesAutoresizingMaskIntoConstraints = false
        loading.isHidden = false
        loading.hidesWhenStopped = false
        return loading
    }()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        addLayout()
        backgroundColor = .yellow
        setupConstrainsts()
        loading.startAnimating()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addLayout() {
        addSubview(loading)
    }
    
    private func setupConstrainsts() {
        NSLayoutConstraint.activate([
            loading.centerXAnchor.constraint(equalTo: centerXAnchor),
            loading.centerYAnchor.constraint(equalTo: centerYAnchor),
            loading.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            loading.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
        ])
        
    }
    
    public func startLoading() {
        loading.startAnimating()
    }

    public func stopLoading() {
        loading.stopAnimating()
    }
}
