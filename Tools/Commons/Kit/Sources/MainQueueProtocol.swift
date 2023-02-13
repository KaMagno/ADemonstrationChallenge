import Foundation

public protocol MainQueueProtocol {
    func async(completion: @escaping () -> ())
}

public final class MainQueue: MainQueueProtocol {
    public init() { }
    public func async(completion: @escaping () -> ()) {
        DispatchQueue.main.async{ completion() }
    }
}

#if canImport(XCTest)
final class MainQueueStub: MainQueueProtocol {
    func async(completion: @escaping () -> ()) {
        completion()
    }
}
#endif
