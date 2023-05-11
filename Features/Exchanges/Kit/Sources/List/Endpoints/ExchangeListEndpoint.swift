import Foundation
import Network

struct ExchangeListEndpoint: Endpoint {
    typealias Response = [Exchange]
    
    var baseEndpoint: BaseEndpoint? = CoinBaseEndpoint()
    
    var path: String {
        "exchanges"
    }
}
