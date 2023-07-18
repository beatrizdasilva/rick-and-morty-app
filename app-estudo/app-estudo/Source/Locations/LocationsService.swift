import API

protocol LocationsServicing {
    func getLocation(completion: @escaping(Result<LocationsResult, ApiError>) -> Void)
}

class LocationsService: LocationsServicing {
    private let api = Api()
    
    func getLocation(completion: @escaping(Result<LocationsResult, ApiError>) -> Void) {
        api.execute(endpoint: LocationEndpoints.locations) { (result: Result<LocationsResult, ApiError>) in
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
