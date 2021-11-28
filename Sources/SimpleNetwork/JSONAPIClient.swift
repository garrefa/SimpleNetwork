
import Foundation

public final class JSONAPIClient: APIClientProtocol {

    public enum NetworkError: Error {
        case malformedURL
        case invalidResponse
        case failedToDecodeResponse
        case original(error: Error)
    }

    required public init() {
    }

    /// - Parameter endpoint: the endpoint to make the request against
    /// - Throws: NetworkError object
    /// - Returns: Decodable object from JSON
    public func request<T:Decodable>(_ endpoint: EndpointProtocol) async throws -> T {
        var components = URLComponents()
        components.scheme = endpoint.scheme
        components.host = endpoint.baseURL
        components.path = endpoint.path
        components.queryItems = endpoint.parameters

        guard let url = components.url else {
            throw NetworkError.malformedURL
        }

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = endpoint.method
        let session = URLSession(configuration: .default)
        return try await withCheckedThrowingContinuation({ continuarion in

            // TODO: Return the data task
            let dataTask = session.dataTask(with: urlRequest) { data, response, error in
                guard error == nil else {
                    // TODO: Implement proper login via DI
                    // TODO: Log all steps of request/response/parsin error
                    print(error? .localizedDescription ?? "Unknown error")
                    let originalError = NetworkError.original(error: error!)
                    return continuarion.resume(throwing: originalError)
                }

                guard response != nil, let data = data else {
                    return continuarion.resume(throwing: NetworkError.invalidResponse)
                }

                guard let responseObject = try? JSONDecoder().decode(T.self, from: data) else {
                    return continuarion.resume(throwing: NetworkError.failedToDecodeResponse)
                }

                DispatchQueue.main.async {
                    return continuarion.resume(returning: responseObject)
                }
            }

            dataTask.resume()
        })
    }
}
