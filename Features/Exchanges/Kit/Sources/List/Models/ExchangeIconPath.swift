import Foundation

struct ExchangeIconPath: Decodable {
    enum CodingKeys: String, CodingKey {
        case exchangeId
        case path = "url"
    }
    
    let exchangeId: String
    let path: String
}
