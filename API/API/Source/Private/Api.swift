final class Api: ApiProtocol {
    private let session: URLSession
    
    init(session: URLSession = URLSession(configuration: .default)) {
        self.session = session
    }
    
    func execute<T>(endpoint: EndpointExposable, completion: @escaping (Result<T, ApiError>) -> Void) where T : Decodable {
        let request: URLRequest
        do {
            request = try createUrlRequest(endpoint: endpoint)
        } catch {
            completion(.failure(.malformedUrl))
            return
        }
        
        let task = session.dataTask(with: request) { [weak self] data, urlResponse, error in
            guard let data = data, let self = self else {
                completion(.failure(.bodyNotFound))
                return
            }
            
            if let error = error {
                completion(.failure(.httpError(error)))
            }
            
            let result = self.processResponse(urlResponse: urlResponse, data: data, type: T.self)
            completion(result)
        }
        
        task.resume()
    }
    
    func execute<T>(endpoint: EndpointExposable) async throws -> T where T : Decodable {
        let request = try createUrlRequest(endpoint: endpoint)
        let (data, urlResponse) = try await session.data(for: request)
        let result = processResponse(urlResponse: urlResponse, data: data, type: T.self)
        
        switch result {
        case .success(let value):
            return value
        case .failure(let error):
            throw error
        }
    }
    
    private func createUrlRequest(endpoint: EndpointExposable) throws -> URLRequest {
        let absoluteUrl = endpoint.baseURL + endpoint.path
        var urlComponent = URLComponents(string: absoluteUrl)
        
        urlComponent?.queryItems = endpoint.parameters.map { URLQueryItem(name: $0.key, value: "\($0.value)") }
        
        guard let url = urlComponent?.url else { throw ApiError.malformedUrl }
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        request.addValue(endpoint.contentType.rawValue, forHTTPHeaderField: "Content-Type")
        
        if let body = endpoint.body {
            request.httpBody = body
        }
        
        endpoint.customHeader.forEach { header in
            request.addValue(header.value, forHTTPHeaderField: header.key)
        }
        
        return request
    }
    
    private func processResponse<T: Decodable>(urlResponse: URLResponse?, data: Data, type: T.Type) -> Result<T, ApiError> {
        guard let httpResponse = urlResponse as? HTTPURLResponse else {
            return .failure(.unknown)
        }
        
        switch httpResponse.statusCode {
        case 200...299:
            return decodeResponse(data: data)
        case 400:
            return .failure(.badRequest)
        case 401:
            return .failure(.notAuthorized)
        default:
            return .failure(.unknown)
        }
    }
    
    private func decodeResponse<T: Decodable>(data: Data) -> Result<T, ApiError> {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .useDefaultKeys
        do {
            let decoded = try decoder.decode(T.self, from: data)
            return .success(decoded)
        } catch {
            return .failure(.decodedError)
        }
    }
}
