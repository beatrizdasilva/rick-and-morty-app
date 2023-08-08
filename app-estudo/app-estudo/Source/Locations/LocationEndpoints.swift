import API

enum LocationEndpoints: EndpointExposable {
    case locations(page: Int?)
    case searchLocations(name: String, page: Int?)
    
    var baseURL: String {
        "https://rickandmortyapi.com/api/"
    }
    
    var path: String {
        "location"
    }
    
    var method: API.HttpMethod {
        .get
    }
    
    var parameters: [String: Any] {
        switch self {
        case let .locations(currentPage):
            guard let page = currentPage else { return [:] }
            return ["page": page]
        case let .searchLocations(name, currentPage):
            guard let page = currentPage else { return ["name": name] }
            return ["name": name, "page": page]
        }
    }
}
