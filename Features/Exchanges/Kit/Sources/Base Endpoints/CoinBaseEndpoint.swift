import Foundation
import Network

struct CoinBaseEndpoint: BaseEndpoint {
    var basePath: String {
        "https://rest.coinapi.io/v1/"
    }
    
    var headers: HTTPHeaders? {
        [
            "Accept": "application/json",
            "Accept-Encoding": "deflate, gzip",
            "X-CoinAPI-Key": "B24B7645-C254-4C56-A58F-C9EE8A77D6C1"
        ]
    }
}
