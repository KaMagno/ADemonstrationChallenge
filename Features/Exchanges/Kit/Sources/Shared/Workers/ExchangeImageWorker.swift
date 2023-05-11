import Commons
import Network
import UIKit

protocol ExchangeImageWorking {
    @discardableResult
    func fetchImage(fromPath path: String, completion: @escaping (Result<Data, Error>) -> Void) -> URLSessionDataTask?
}

final class ExchangeImageWorker {
    enum Errors: Error {
        case urlMistypinh
        case imageCouldNotLoadFromData
    }
    
    private let service: EndpointRequesterProtocol
    private let mainQueue: MainQueueProtocol
    
    init(service: EndpointRequesterProtocol = Service(),
         mainQueue: MainQueueProtocol = MainQueue()) {
        self.service = service
        self.mainQueue = mainQueue
    }
}

extension ExchangeImageWorker: ExchangeImageWorking {
    @discardableResult
    func fetchImage(fromPath path: String, completion: @escaping (Result<Data, Error>) -> Void) -> URLSessionDataTask? {
        let imageSessionTask = service.request(urlPath: path) {[weak self] result in
            guard let self = self else {
                return
            }
            
            self.mainQueue.async {
                completion(result)
            }
        }
        
        imageSessionTask?.resume()
        return imageSessionTask
    }
}
