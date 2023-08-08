import UI

protocol LocationsViewModelInput {
    func loadLocations()
    func getNextLocations()
}

protocol LocationsViewModelProtocol: LocationsViewModelInput {
    var display: LocationsViewControllerDisplay? { get set }
}

class LocationsViewModel: LocationsViewModelProtocol {
    weak var display: LocationsViewControllerDisplay?
    
    private let service: LocationsServicing
    private var currentPage: Int
    private var maxPages: Int
    
    init(service: LocationsServicing) {
        self.service = service
        self.currentPage = 1
        self.maxPages = 1
    }
    
    func loadLocations() {
        service.getLocation { [weak self] result in
            switch result {
            case .success(let value):
                self?.currentPage = 1
                self?.maxPages = value.maxPages
                
                let informationsViewModel = value.locations.map {
                    InformationViewModel(title: $0.name, primaryText: $0.type, secondaryText: $0.dimension)
                }
                self?.display?.informations = informationsViewModel
            case .failure:
                break
            }
        }
    }
    
    func getNextLocations() {
        if currentPage >= maxPages {
            return
        } else {
            currentPage += 1
            service.getLocation(by: currentPage) { [weak self] result in
                switch result {
                case .success(let value):
                    let informationsViewModel = value.locations.map {
                        InformationViewModel(title: $0.name, primaryText: $0.type, secondaryText: $0.dimension)
                    }
                    self?.display?.addMoreLocations(informationsViewModel)
                case .failure:
                    break
                }
            }
        }
    }
}
