public protocol EndpointExposable {
    // Ex baseURL: www.g1.globo.com/
    var baseURL: String { get }
    // Ex path: www.g1.globo.com/ciencia (apenas o ciencia)
    var path: String { get }
    var method: HttpMethod { get }
    // Ex parameters: www.g1.globo.com/busca/?q=cachorro
    // Sendo q a chave(String) e cachorro o valor(Any)
    var parameters: [String: Any] { get }
    var body: Data? { get }
    var customHeader: [String: String] { get }
    var contentType: ContentType { get }
}
