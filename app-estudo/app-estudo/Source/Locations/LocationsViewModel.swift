import UI

protocol LocationsViewModelInput {
    func loadLocations()
}

protocol LocationsViewModelProtocol: LocationsViewModelInput {
    var display: LocationsViewControllerDisplay? { get set }
}

class LocationsViewModel: LocationsViewModelProtocol {
    weak var display: LocationsViewControllerDisplay?
    
    private let service: LocationsServicing
    
    init(service: LocationsServicing) {
        self.service = service
    }
    
    func loadLocations() {
        service.getLocation { [weak self] result in
            switch result {
            case .success(let value):
                let informationsViewModel = value.locations.map {
                    InformationViewModel(title: $0.name, primaryText: $0.type, secondaryText: $0.dimension)
                }
                self?.display?.informations = informationsViewModel
            case .failure:
                break
            }
        }
    }
}
