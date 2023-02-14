import XCTest
@testable import Exchanges

final class ExchangeListWorkingStub: ExchangeListWorking {
    enum Errors: Error {
        case generic
    }
    var shouldThrowError = false
    func fetchExchangeIconPaths(completion: @escaping (Result<[ExchangeIconPath], Error>) -> ()) {
        if shouldThrowError {
            completion(.failure(Errors.generic))
            return
        }
        do {
            let exchangeIconPaths: [ExchangeIconPath] = try JSONDecoder.decode(fileName: "ExchangeImagePaths")
            completion(.success(exchangeIconPaths))
        } catch {
            debugPrint(error)
            completion(.failure(error))
        }
    }
    
    func fetchExchangeList(completion: @escaping (Result<[Exchange], Error>) -> ()) {
        if shouldThrowError {
            completion(.failure(Errors.generic))
            return
        }
        do {
            let exchangeIconPaths: [Exchange] = try JSONDecoder.decode(fileName: "ExchangeList")
            completion(.success(exchangeIconPaths))
        } catch {
            debugPrint(error)
            completion(.failure(error))
        }
    }
}

final class ExchangeListPresentingSpy: ExchangeListPresenting {
    private(set) var exchanges = [Exchange]()
    private(set) var exchangeIconPaths = [ExchangeIconPath]()
    private(set) var presentExchangesCallCount = 0
    private(set) var presentExchangeIconPathsCallCount = 0
    private(set) var presentErrorCallCount = 0
    private(set) var presentLoadCallCount = 0
    private(set) var hideLoadCallCount = 0

    func present(exchanges: [Exchange]) {
        self.exchanges = exchanges
        presentExchangesCallCount += 1
    }

    func present(exchangeIconPaths: [ExchangeIconPath]) {
        self.exchangeIconPaths = exchangeIconPaths
        presentExchangeIconPathsCallCount += 1
    }

    func presentError() {
        presentErrorCallCount += 1
    }

    func presentLoad() {
        presentLoadCallCount += 1
    }

    func hideLoad() {
        hideLoadCallCount += 1
    }
}


final class ExchangeListInteractorTests: XCTestCase {
    private let presenterSpy = ExchangeListPresentingSpy()
    private let exchangeStub = ExchangeListWorkingStub()
    private lazy var sut = ExchangeListInteractor(presenter: presenterSpy,
                                                  exchangeListWorker: exchangeStub)
    
    func test_requestExchangeListData_success() {
        // When
        sut.requestExchangeListData()
        
        // Then
        XCTAssertEqual(presenterSpy.presentExchangeIconPathsCallCount, 1)
        XCTAssertEqual(presenterSpy.presentExchangesCallCount, 1)
        XCTAssertEqual(presenterSpy.hideLoadCallCount, 1)
        XCTAssertEqual(presenterSpy.presentErrorCallCount, 0)
        XCTAssertEqual(presenterSpy.exchanges.count, 2)
        XCTAssertEqual(presenterSpy.exchangeIconPaths.count, 3)
    }
    
    func test_requestExchangeListData_failure() {
        // Given
        exchangeStub.shouldThrowError = true
        
        // When
        sut.requestExchangeListData()
        
        // Then
        XCTAssertEqual(presenterSpy.presentExchangeIconPathsCallCount, 0)
        XCTAssertEqual(presenterSpy.presentExchangesCallCount, 0)
        XCTAssertEqual(presenterSpy.hideLoadCallCount, 1)
        XCTAssertEqual(presenterSpy.presentErrorCallCount, 2)
        XCTAssertEqual(presenterSpy.exchanges.count, 0)
        XCTAssertEqual(presenterSpy.exchangeIconPaths.count, 0)
    }
    
    func test_requestExchangeIconPathList_success() {
        // When
        sut.requestExchangeIconPathList()
        
        // Then
        XCTAssertEqual(presenterSpy.presentExchangeIconPathsCallCount, 2)
        XCTAssertEqual(presenterSpy.presentExchangesCallCount, 0)
        XCTAssertEqual(presenterSpy.hideLoadCallCount, 0)
        XCTAssertEqual(presenterSpy.presentErrorCallCount, 0)
        XCTAssertEqual(presenterSpy.exchanges.count, 0)
        XCTAssertEqual(presenterSpy.exchangeIconPaths.count, 3)
    }
    
    func test_requestExchangeIconPathList_failure() {
        // Given
        exchangeStub.shouldThrowError = true
        
        // When
        sut.requestExchangeIconPathList()
        
        // Then
        XCTAssertEqual(presenterSpy.presentExchangeIconPathsCallCount, 0)
        XCTAssertEqual(presenterSpy.presentExchangesCallCount, 0)
        XCTAssertEqual(presenterSpy.hideLoadCallCount, 0)
        XCTAssertEqual(presenterSpy.presentErrorCallCount, 2)
        XCTAssertEqual(presenterSpy.exchanges.count, 0)
        XCTAssertEqual(presenterSpy.exchangeIconPaths.count, 0)
    }
}
