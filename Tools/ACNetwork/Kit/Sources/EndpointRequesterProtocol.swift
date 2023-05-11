import Foundation

public typealias EndpointResponseCompletion<T: Decodable> = (Result<T, Error>) -> Void

public protocol EndpointRequesterProtocol {
    @discardableResult
    func request<S: Endpoint>(endpoint: S,
                              keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy,
                              dateDecodingStrategy: JSONDecoder.DateDecodingStrategy,
                              completion: @escaping EndpointResponseCompletion<S.Response>) -> URLSessionDataTask?
    func request(urlPath: String,
                 keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy,
                 dateDecodingStrategy: JSONDecoder.DateDecodingStrategy,
                 completion: @escaping (Result<Data, Error>) -> Void) -> URLSessionDataTask?
}

public extension EndpointRequesterProtocol {
    func request<S: Endpoint>(endpoint: S,
                              keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy = .convertFromSnakeCase,
                              dateDecodingStrategy: JSONDecoder.DateDecodingStrategy = .iso8601,
                              completion: @escaping EndpointResponseCompletion<S.Response>) -> URLSessionDataTask? {
        request(endpoint: endpoint,
                keyDecodingStrategy: keyDecodingStrategy,
                dateDecodingStrategy: dateDecodingStrategy,
                completion: completion)
    }
    func request(urlPath: String,
                 keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy = .convertFromSnakeCase,
                 dateDecodingStrategy: JSONDecoder.DateDecodingStrategy = .iso8601,
                 completion: @escaping (Result<Data, Error>) -> Void) -> URLSessionDataTask? {
        request(urlPath: urlPath,
                keyDecodingStrategy: keyDecodingStrategy,
                dateDecodingStrategy: dateDecodingStrategy,
                completion: completion)
    }
}
