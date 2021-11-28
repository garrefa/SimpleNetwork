
import Foundation

public protocol EndpointProtocol {
    /// HTTP or HTTPS
    var scheme: String { get }

    // Example: "api.flickr.com"
    var baseURL: String { get }

    // "/services/rest/"
    var path: String { get }

    // [URLQueryItem(name: "api_key", value: API_KEY)]
    var parameters: [URLQueryItem] { get }

    // "GET"
    var method: String { get }

    // TODO: Support headers
}
