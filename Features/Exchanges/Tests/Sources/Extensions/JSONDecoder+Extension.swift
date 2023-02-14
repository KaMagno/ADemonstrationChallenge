import Foundation

extension JSONDecoder {
    enum Errors: Error {
        case didNotFindStubJson
    }
    
    func decode<T: Decodable>(fileName: String) throws -> T {
        guard let jsonPath = ExchangesTestsResources.bundle.url(forResource: fileName,
                                                                withExtension: "json") else {
            throw Errors.didNotFindStubJson
        }
        let data = try Data(contentsOf: jsonPath)
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .iso8601
        return try decoder.decode(T.self, from: data)
    }
}
