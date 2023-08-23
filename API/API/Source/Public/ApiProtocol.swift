import Foundation

public protocol ApiProtocol {
    func execute<T: Decodable>(endpoint: EndpointExposable, completion: @escaping (Result<T, ApiError>) -> Void)
    func execute<T: Decodable>(endpoint: EndpointExposable) async throws -> T
    func cancel()
}
