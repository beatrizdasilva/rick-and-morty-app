import UI

protocol EpisodesViewModelInput {
    func loadEpisodes()
    func getNextEpisodes()
    func searchEpisode(name: String)
}

protocol EpisodesViewModelProtocol: EpisodesViewModelInput {
    var display: EpisodesViewControllerDisplay? { get set }
}

class EpisodesViewModel: EpisodesViewModelProtocol {
    weak var display: EpisodesViewControllerDisplay?
    
    private let service: EpisodesServicing
    private var currentPage: Int
    private var maxPages: Int
    private var informations: [InformationViewModel] = []
    private var textTyped: String
    
    init(service: EpisodesServicing) {
        self.service = service
        self.currentPage = 1
        self.maxPages = 1
        self.textTyped = ""
    }
    
    func loadEpisodes() {
        service.getEpisode { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let value):
                self.currentPage = 1
                self.maxPages = value.maxPages
                
                let informationsViewModel = value.episodes.map {
                    InformationViewModel(title: $0.episode, primaryText: $0.name, secondaryText: nil)
                }
                self.informations = informationsViewModel
                self.display?.reloadEpisodes(episode: informationsViewModel, isLoadAllInformation: value.maxPages == 1)
            case .failure:
                break
            }
        }
    }
    
    func getNextEpisodes() {
        if currentPage >= maxPages {
            return
        } else {
            currentPage += 1
            service.getEpisodeBySearch(by: textTyped, page: currentPage) { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let value):
                    let informationsViewModel = value.episodes.map {
                        InformationViewModel(title: $0.episode, primaryText: $0.name, secondaryText: nil)
                    }
                    self.informations.append(contentsOf: informationsViewModel)
                    self.display?.reloadEpisodes(episode: informations, isLoadAllInformation: currentPage >= maxPages)
                case .failure:
                    break
                }
            }
        }
    }
    
    func searchEpisode(name: String) {
        self.textTyped = name
        service.getEpisodeBySearch(by: name, page: 1) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let value):
                self.currentPage = 1
                self.maxPages = value.maxPages
                
                let informationsViewModel = value.episodes.map {
                    InformationViewModel(title: $0.episode, primaryText: $0.name, secondaryText: nil)
                }
                self.informations = informationsViewModel
                self.display?.reloadEpisodes(episode: informationsViewModel, isLoadAllInformation: value.maxPages == 1)
            case .failure:
                break
            }
        }
    }
}
