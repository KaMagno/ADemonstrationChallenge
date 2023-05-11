import Foundation
import Network

struct ExchangeIconPathsEndpoint {
    /*
     Use an different Size to define the Image size here because the context is the Server Service
     So in these case the sizes are the sizes defined on the server not in the App
     **/
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
