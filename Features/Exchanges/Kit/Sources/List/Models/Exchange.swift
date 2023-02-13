import Foundation

struct Exchange: Decodable {
    enum CodingKeys: String, CodingKey {
        case exchangeId
        case name
        case website
        case dataStart
        case dataEnd
        case dataSymbolsCount
        case volume1HourUsd = "volume1HrsUsd"
        case volume1DayUsd
        case volume1MonthUsd = "volume1MthUsd"
    }
    
    let exchangeId: String
    let name: String
    let website: String
    let dataStartText: String?
    let dataEndText: String?
    let dataSymbolsCount: Int
    let volume1HourUsd: Double
    let volume1DayUsd: Double
    let volume1MonthUsd: Double
    
    init(from decoder: Decoder) throws {
        let container: KeyedDecodingContainer<Exchange.CodingKeys> = try decoder.container(keyedBy: Exchange.CodingKeys.self)
        
        self.exchangeId = try container.decode(String.self, forKey: Exchange.CodingKeys.exchangeId)
        self.name = try container.decode(String.self, forKey: Exchange.CodingKeys.name)
        self.website = try container.decode(String.self, forKey: Exchange.CodingKeys.website)
        self.dataStartText = try container.decodeIfPresent(String.self, forKey: Exchange.CodingKeys.dataStart)
        self.dataEndText = try container.decodeIfPresent(String.self, forKey: Exchange.CodingKeys.dataEnd)
        self.dataSymbolsCount = try container.decode(Int.self, forKey: Exchange.CodingKeys.dataSymbolsCount)
        self.volume1HourUsd = try container.decode(Double.self, forKey: Exchange.CodingKeys.volume1HourUsd)
        self.volume1DayUsd = try container.decode(Double.self, forKey: Exchange.CodingKeys.volume1DayUsd)
        self.volume1MonthUsd = try container.decode(Double.self, forKey: Exchange.CodingKeys.volume1MonthUsd)
        
    }
}

extension Exchange {
    private var dataDateFormatter: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter
    }
    var dataStart: Date? {
        guard let dataStartText = dataStartText else { return nil }
        return dataDateFormatter.date(from: dataStartText)
    }
    var dataEnd: Date? {
        guard let dataEndText = dataEndText else { return nil }
        return dataDateFormatter.date(from: dataEndText)
    }
}
