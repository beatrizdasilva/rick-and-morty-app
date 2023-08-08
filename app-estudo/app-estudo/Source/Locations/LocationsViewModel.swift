import UI

protocol LocationsViewModelInput {
    func loadLocations()
    func getNextLocations()
    func searchLocation(name: String)
}

protocol LocationsViewModelProtocol: LocationsViewModelInput {
    var display: LocationsViewControllerDisplay? { get set }
}

class LocationsViewModel: LocationsViewModelProtocol {
    weak var display: LocationsViewControllerDisplay?
    
    private let service: LocationsServicing
    private var currentPage: Int
    private var maxPages: Int
    private var informations: [InformationViewModel] = []
    
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
                self?.informations = informationsViewModel
                self?.display?.reloadLocations(location: informationsViewModel, isLoadAllInformation: false)
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
                guard let self = self else { return }
                switch result {
                case .success(let value):
                    let informationsViewModel = value.locations.map {
                        InformationViewModel(title: $0.name, primaryText: $0.type, secondaryText: $0.dimension)
                    }
                    self.informations.append(contentsOf: informationsViewModel)
                    self.display?.reloadLocations(location: informations, isLoadAllInformation: currentPage >= maxPages)
                case .failure:
                    break
                }
            }
        }
    }
    
    func searchLocation(name: String) {
        service.getLocationBySearch(by: name, page: 1) { [weak self] result in
            switch result {
            case .success(let value):
                self?.currentPage = 1
                self?.maxPages = value.maxPages
                
                let informationsViewModel = value.locations.map {
                    InformationViewModel(title: $0.name, primaryText: $0.type, secondaryText: $0.dimension)
                }
                self?.informations = informationsViewModel
                self?.display?.reloadLocations(location: informationsViewModel, isLoadAllInformation: false)
            case .failure:
                break
            }
        }
    }
}
