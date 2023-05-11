import Foundation

public final class ImageSession {
    public static let shared: ImageSession = ImageSession()
    public let session: URLSession
    
    private init() {
        let configurator = URLSessionConfiguration.default
        configurator.requestCachePolicy = .returnCacheDataElseLoad
        session = URLSession(configuration: configurator)
    }
}
