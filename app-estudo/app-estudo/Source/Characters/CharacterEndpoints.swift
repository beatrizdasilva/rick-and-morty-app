import API

enum CharacterEndpoints: EndpointExposable {
    case characters(page: Int?)
    case searchCharacters(name: String, page: Int?)
    
    var baseURL: String {
        "https://rickandmortyapi.com/api/"
    }
    
    var path: String {
        "character"
    }
    
    var method: API.HttpMethod {
        .get
    }
    
    var parameters: [String : Any] {
        switch self {
        case let .characters(currentPage):
            guard let page = currentPage else { return [:] }
            return ["page": page]
        case let .searchCharacters(name, currentPage):
            guard let page = currentPage else { return ["name": name] }
            return ["name": name, "page": page]
        }
    }
}
