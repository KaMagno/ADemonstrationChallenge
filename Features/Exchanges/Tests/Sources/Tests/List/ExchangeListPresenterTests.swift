import XCTest
@testable import Exchanges

final class ExchangeListDisplayingSpy: ExchangeListDisplaying {
    private(set) var exchanges: [Exchange] = []
    private(set) var exchangeIconPaths: [ExchangeIconPath] = []
    private(set) var exchangesDisplayed = 0
    private(set) var exchangeIconListUpdated = 0
    private(set) var errorDisplayed = 0
    private(set) var loadingDisplayed = 0
    private(set) var loadingUndisplayed = 0

    func display(exchanges: [Exchange]) {
        self.exchanges = exchanges
        exchangesDisplayed += 1
    }

    func update(exchangeIconList: [ExchangeIconPath]) {
        exchangeIconPaths = exchangeIconList
        exchangeIconListUpdated += 1
    }

    func displayError() {
        errorDisplayed += 1
    }

    func displayLoading() {
        loadingDisplayed += 1
    }

    func undisplayLoading() {
        loadingUndisplayed += 1
    }
}

final class ExchangeListPresenterTests: XCTestCase {
    private let displaySpy: ExchangeListDisplayingSpy = ExchangeListDisplayingSpy()
    private lazy var sut: ExchangeListPresenter = {
        let presenter = ExchangeListPresenter()
        presenter.viewController = displaySpy
        return presenter
    }()
    
    private func loadExchanges() throws -> [Exchange] {
        try JSONDecoder.decode(fileName: "ExchangeList")
    }
    
    private func loadExchangePaths() throws -> [ExchangeIconPath] {
        try JSONDecoder.decode(fileName: "ExchangeImagePaths")
    }
    
    func test_presentExchanges_displayExchangesIsCalled() throws {
        // Given
        let exchanges = try loadExchanges()
        
        // When
        sut.present(exchanges: exchanges)
        
        // Then
        XCTAssertEqual(displaySpy.exchangesDisplayed, 1)
        XCTAssertEqual(displaySpy.exchanges.count, exchanges.count)
    }
    
    func test_presentExchangeIconPaths_updateExchangeIconListIsCalled() throws {
        // Given
        let exchangeIconPaths = try loadExchangePaths()
        
        // When
        sut.present(exchangeIconPaths: exchangeIconPaths)
        
        // Then
        XCTAssertEqual(displaySpy.exchangeIconListUpdated, 1)
        XCTAssertEqual(displaySpy.exchangeIconPaths.count, exchangeIconPaths.count)
    }
    
    func test_presentError_displayErrorIsCalled() {
        // When
        sut.presentError()
        
        // Then
        XCTAssertEqual(displaySpy.errorDisplayed, 1)
    }
    
    func test_presentLoad_displayLoadingIsCalled() {
        // When
        sut.presentLoad()
        
        // Then
        XCTAssertEqual(displaySpy.loadingDisplayed, 1)
    }
    
    func test_hideLoad_undisplayLoadingIsCalled() {
        // When
        sut.hideLoad()
        
        // Then
        XCTAssertEqual(displaySpy.loadingUndisplayed, 1)
    }
}

