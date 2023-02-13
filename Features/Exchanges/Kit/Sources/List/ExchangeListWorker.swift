import Foundation
import MBNetwork
import Commons

protocol ExchangeListWorking {
    func fetchExchangeIconPaths(completion: @escaping (Result<[ExchangeIconPath], Error>) -> ())
    func fetchExchangeList(completion: @escaping (Result<[Exchange], Error>) -> ())
}

struct ExchangeListWorker {
    var task: URLSessionDataTask?
    
    private let service: Service
    private let mainQueue: MainQueueProtocol
    
    init(service: Service = .init(), mainQueue: MainQueueProtocol = MainQueue()) {
        self.service = service
        self.mainQueue = mainQueue
    }
}

extension ExchangeListWorker: ExchangeListWorking {
    func fetchExchangeIconPaths(completion: @escaping (Result<[ExchangeIconPath], Error>) -> ()) {
        let endpoint = ExchangeIconPathsEndpoint()
        service.request(endpoint: endpoint,
                        keyDecodingStrategy: .convertFromSnakeCase) { result in
            mainQueue.async {
                completion(result)
            }
        }
    }
    
    func fetchExchangeList(completion: @escaping (Result<[Exchange], Error>) -> ()) {
        let endpoint = ExchangeListEndpoint()
        service.request(endpoint: endpoint,
                        keyDecodingStrategy: .convertFromSnakeCase,
                        dateDecodingStrategy: .iso8601) { result in
            mainQueue.async {
                completion(result)
            }
        }
    }
}
