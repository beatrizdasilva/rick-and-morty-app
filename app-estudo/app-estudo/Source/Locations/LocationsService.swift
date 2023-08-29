import API

protocol LocationsServicing {
    func getLocation(completion: @escaping(Result<LocationsResult, ApiError>) -> Void)
    func getLocationBySearch(by name: String, page: Int, completion: @escaping(Result<LocationsResult, ApiError>) -> Void)
}

class LocationsService: LocationsServicing {
    private let api = Api()

    func getLocation(completion: @escaping(Result<LocationsResult, ApiError>) -> Void) {
        api.cancel()
        api.execute(endpoint: LocationEndpoints.locations(page: nil)) {
            (result: Result<LocationsResult, ApiError>) in
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

    func getLocationBySearch(by name: String, page: Int, completion: @escaping (Result<LocationsResult, API.ApiError>) -> Void) {
        api.cancel()
        api.execute(endpoint: LocationEndpoints.searchLocations(name: name, page: page)) {
            (result: Result<LocationsResult, ApiError>) in
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
