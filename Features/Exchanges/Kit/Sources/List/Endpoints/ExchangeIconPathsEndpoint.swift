import Foundation
import MBNetwork

struct ExchangeIconPathsEndpoint {
    enum Size: Int {
        case small = 32
        case medium = 64
        case large = 128
    }
    
    private let size: Int
    
    init(size: Size = .medium) {
        self.size = size.rawValue
    }
}

extension ExchangeIconPathsEndpoint: Endpoint {
    typealias Response = [ExchangeIconPath]
    
    var path: String {
        "exchanges/icons/\(size)"
    }
    
    var baseEndpoint: BaseEndpoint? {
        CoinBaseEndpoint()
    }
}
