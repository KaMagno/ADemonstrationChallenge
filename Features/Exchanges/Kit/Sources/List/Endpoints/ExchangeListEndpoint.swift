import Foundation
import ACNetwork

struct ExchangeListEndpoint: Endpoint {
    typealias Response = [Exchange]
    
    var baseEndpoint: BaseEndpoint? = CoinBaseEndpoint()
    
    var path: String {
        "exchanges"
    }
}
