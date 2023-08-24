import API

enum EpisodeEndpoints: EndpointExposable {
    case episodes(page: Int?)
    case searchEpisodes(name: String, page: Int?)
    
    var baseURL: String {
        "https://rickandmortyapi.com/api/"
    }
    
    var path: String {
        "episode"
    }
    
    var method: API.HttpMethod {
        .get
    }
    
    var parameters: [String : Any] {
        switch self {
        case let .episodes(currentPage):
            guard let page = currentPage else { return [:] }
            return ["page": page]
        case let .searchEpisodes(name, currentPage):
            guard let page = currentPage else { return ["name": name] }
            return ["name": name, "page": page]
        }
    }
}
