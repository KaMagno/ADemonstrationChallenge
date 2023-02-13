import Foundation
import MBNetwork

struct ExchangeListEndpoint: Endpoint {
    typealias Response = [Exchange]
    
    var baseEndpoint: BaseEndpoint? = CoinBaseEndpoint()
    
    var path: String {
        "exchanges"
    }
}
