import API

protocol EpisodesServicing {
    func getEpisode(completion: @escaping(Result<EpisodesResult, ApiError>) -> Void)
    func getEpisode(by page: Int, completion: @escaping(Result<EpisodesResult, ApiError>) -> Void)
    func getEpisodeBySearch(by name: String, page: Int, completion: @escaping(Result<EpisodesResult, ApiError>) -> Void)
}

class EpisodesService: EpisodesServicing {
    private let api = Api()
    
    func getEpisode(completion: @escaping (Result<EpisodesResult, API.ApiError>) -> Void) {
        api.cancel()
        api.execute(endpoint: EpisodeEndpoints.episodes(page: nil)) { (result: Result<EpisodesResult, ApiError>) in
            DispatchQueue.main.async {
                switch result {
                case .success(let value):
                    completion(.success(value))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
    
    func getEpisode(by page: Int, completion: @escaping (Result<EpisodesResult, API.ApiError>) -> Void) {
        api.cancel()
        api.execute(endpoint: EpisodeEndpoints.episodes(page: page)) { (result: Result<EpisodesResult, ApiError>) in
            DispatchQueue.main.async {
                switch result {
                case .success(let value):
                    completion(.success(value))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
    
    func getEpisodeBySearch(by name: String, page: Int, completion: @escaping (Result<EpisodesResult, API.ApiError>) -> Void) {
        api.cancel()
        api.execute(endpoint: EpisodeEndpoints.searchEpisodes(name: name, page: page)) { (result: Result<EpisodesResult, ApiError>) in
            DispatchQueue.main.async {
                switch result {
                case .success(let value):
                    completion(.success(value))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
}
