import Foundation

public class Service {
    private var tasks: [String: URLSessionTask] = [:]
    
    private let session: URLSession
    
    public init(session: URLSession = .shared) {
        self.session = session
    }
}

private extension Service {
    enum Errors: Error {
        case unknow
    }
    
    func handle<T: Decodable>(data: Data?,
                              keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy = .useDefaultKeys,
                              dateDecodingStrategy: JSONDecoder.DateDecodingStrategy = .deferredToDate
    ) -> T? {
        guard let data = data else { return nil }
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = keyDecodingStrategy
        decoder.dateDecodingStrategy = dateDecodingStrategy
        var decodedObject: T?
        do {
            decodedObject = try decoder.decode(T.self, from: data)
        } catch {
            debugPrint("--- Decode Error ---")
            if let jsonString = String(data: data, encoding: .utf8) {
                debugPrint("-- Orginal JSON --")
                debugPrint(jsonString)
                debugPrint("-- End orginal JSON --")
            }
            debugPrint(error)
        }
        return decodedObject
    }
}

extension Service: EndpointRequesterProtocol {
    @discardableResult
    public func request<S: Endpoint>(endpoint: S,
                                     keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy = .useDefaultKeys,
                                     dateDecodingStrategy: JSONDecoder.DateDecodingStrategy = .deferredToDate,
                                     completion: @escaping EndpointResponseCompletion<S.Response>) -> URLSessionDataTask? {
        let requestFactory = RequestFactory(endpoint: endpoint)
        var request: URLRequest
        
        do {
            request = try requestFactory.generateURLRequest()
        } catch {
            completion(.failure(error))
            return nil
        }
        
        let task = session.dataTask(with: request) { [weak self] data, response, error in
            guard let self = self else { return }
            if let response = response {
                debugPrint("--- URL Response ---")
                debugPrint(response)
                debugPrint("--- End URL Response ---")
            }
            if let error = error {
                completion(.failure(error))
            }
            if let object: S.Response = self.handle(data: data,
                                                    keyDecodingStrategy: keyDecodingStrategy,
                                                    dateDecodingStrategy: dateDecodingStrategy) {
                completion(.success(object))
            }
        }
        
        task.resume()
        
        return task
    }
    
    public func request(urlPath: String, keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy, dateDecodingStrategy: JSONDecoder.DateDecodingStrategy, completion: @escaping (Result<Data, Error>) -> Void) -> URLSessionDataTask? {
        
        guard let url = URL(string: urlPath) else {
            return nil
        }
        
        let request = URLRequest(url: url)
        
        let task = session.dataTask(with: request) { data, response, error in
            if let response = response {
                debugPrint("--- URL Response ---")
                debugPrint(response)
                debugPrint("--- End URL Response ---")
            }
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else {
                completion(.failure(Errors.unknow))
                return
            }
            completion(.success(data))
        }
        
        task.resume()
        
        return task
    }
}
