
public protocol APIClientProtocol {
    init()

    /// - Parameter endpoint: the endpoint to make the request against
    /// - Throws: Error object
    /// - Returns: Decodable object
    func request<T:Decodable>(_ endpoint: EndpointProtocol) async throws -> T
}
