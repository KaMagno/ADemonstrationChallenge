import Foundation

public typealias EndpointResponseCompletion<T: Decodable> = (Result<T, Error>) -> Void

public protocol EndpointRequesterProtocol {
    @discardableResult
    func request<S: Endpoint>(endpoint: S,
                              keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy,
                              dateDecodingStrategy: JSONDecoder.DateDecodingStrategy,
                              completion: @escaping EndpointResponseCompletion<S.Response>) -> URLSessionDataTask?
}
