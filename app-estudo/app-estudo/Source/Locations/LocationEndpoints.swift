import API

enum LocationEndpoints: EndpointExposable {
    case locations
    
    var baseURL: String {
        return "https://rickandmortyapi.com/api/"
    }
    
    var path: String {
        return "location"
    }
    
    var method: API.HttpMethod {
        return .get
    }
}
