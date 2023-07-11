import API

protocol LocationsServicing  {
    func getLocation(completion: @escaping(Result<, ApiError>) -> Void)
}
