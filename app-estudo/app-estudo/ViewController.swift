import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .purple
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init code has not been implemented")
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
}
