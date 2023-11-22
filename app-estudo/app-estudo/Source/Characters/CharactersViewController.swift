import UI
import UIKit

protocol CharactersViewControllerDisplay: AnyObject {
    func reloadCharacters(character: [ProfileViewModel], isLoadAllInformation: Bool)
}

class CharactersViewController: UIViewController, CharactersViewControllerDisplay {
    private var viewModel: CharactersViewModelProtocol
    private var isLoadAllInformation: Bool = true
    private var profilesViewModel: [ProfileViewModel] = []
    
    private lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        let width = view.bounds.size.width
        
        flowLayout.scrollDirection = .horizontal
        flowLayout.sectionInset = .zero
        flowLayout.minimumLineSpacing = .zero
        flowLayout.minimumInteritemSpacing = .zero
        
        let collection = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
        collection.collectionViewLayout = flowLayout
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.showsHorizontalScrollIndicator = false
        collection.dataSource = self
        collection.delegate = self
        collection.backgroundColor = .clear
        collection.isPagingEnabled = true
        return collection
    }()
    
    private lazy var previousButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "chevron.compact.left"), for: .normal)
        button.contentHorizontalAlignment = .fill
        button.contentVerticalAlignment = .fill
        button.addTarget(self, action: #selector(previousCharacter), for: .touchUpInside)
        return button
    }()
    
    private lazy var nextButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "chevron.compact.right"), for: .normal)
        button.contentHorizontalAlignment = .fill
        button.contentVerticalAlignment = .fill
        button.addTarget(self, action: #selector(nextCharacter), for: .touchUpInside)
        return button
    }()
    
    @objc func previousCharacter(sender: UIButton) {
        scrollToPreviousItem()
    }
    
    @objc func nextCharacter(sender: UIButton) {
        scrollToNextItem()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureCollectionView()
        addLayout()
        setupConstrainsts()
        viewModel.loadCharacters()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        self.navigationItem.searchController = searchController
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Characters"
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init code has not been implemented")
    }
    
    init(viewModel: CharactersViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.viewModel.display = self
    }
    
    private func configureCollectionView() {
        collectionView.register(
            ProfileUICollectionViewCell.self,
            forCellWithReuseIdentifier: String(
                describing: ProfileUICollectionViewCell.self
            )
        )
    }
    
    private func addLayout() {
        view.addSubview(collectionView)
        view.addSubview(previousButton)
        view.addSubview(nextButton)
    }
    
    private func setupConstrainsts() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            previousButton.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            previousButton.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            previousButton.trailingAnchor.constraint(equalTo: collectionView.leadingAnchor),
            previousButton.widthAnchor.constraint(equalToConstant: 50),
            previousButton.heightAnchor.constraint(equalToConstant: 80)
        ])
        
        NSLayoutConstraint.activate([
            nextButton.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            nextButton.leadingAnchor.constraint(equalTo: collectionView.trailingAnchor),
            nextButton.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            nextButton.widthAnchor.constraint(equalToConstant: 50),
            nextButton.heightAnchor.constraint(equalToConstant: 80)
        ])
    }
    
    func reloadCharacters(character: [ProfileViewModel], isLoadAllInformation: Bool) {
        self.isLoadAllInformation = isLoadAllInformation
        self.profilesViewModel = character
        collectionView.reloadData()
    }
}

extension CharactersViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        profilesViewModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: String(describing: ProfileUICollectionViewCell.self),
            for: indexPath
        ) as? ProfileUICollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let profileViewModel = profilesViewModel[indexPath.row]
        cell.configureView(profileViewModel: profileViewModel)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == profilesViewModel.count - 1 {
            viewModel.getNextCharacters()
        }
    }
}

extension CharactersViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
}

extension CharactersViewController {
    func scrollToNextItem() {
        let row = collectionView.contentOffset.x / collectionView.bounds.size.width
        if row < CGFloat(profilesViewModel.count - 1) {
            moveToItem(row: Int(floor(row + 1)))
        }
    }
    
    func scrollToPreviousItem() {
        let row = collectionView.contentOffset.x / collectionView.bounds.size.width
        if row > 0 {
            moveToItem(row: Int(floor(row - 1)))
        }
    }
    
    func moveToItem(row: Int) {
        collectionView.scrollToItem(at: .init(row: row, section: 0), at: .centeredHorizontally, animated: true)
    }
}

extension CharactersViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchText = searchController.searchBar.text
        viewModel.searchCharacter(name: searchText ?? "")
        print(searchText)
    }
}
