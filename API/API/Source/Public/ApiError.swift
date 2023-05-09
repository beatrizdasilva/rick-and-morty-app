public enum ApiError: Error {
    case malformedUrl
    case bodyNotFound
    case httpError(Error)
    case unknown
    case badRequest
    case notAuthorized
    case decodedError
}
