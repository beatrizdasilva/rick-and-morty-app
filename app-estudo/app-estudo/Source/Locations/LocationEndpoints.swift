import API

enum LocationEndpoints: EndpointExposable {
    case locations(page: Int?)
    
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
        guard case .locations(let currentPage) = self, let page = currentPage else { return [:] }
        return ["page": page]
    }
}
