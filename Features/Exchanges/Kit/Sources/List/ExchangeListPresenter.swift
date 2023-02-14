import UIKit

protocol ExchangeListPresenting {
    // Change Presentated Info functions
    func present(exchanges: [Exchange])
    func present(exchangeIconPaths: [ExchangeIconPath])
    func presentError()
    func presentLoad()
    func hideLoad()
}

final class ExchangeListPresenter {
    // MARK: VIP Properties
    let viewController: ExchangeListDisplaying
    
    init(viewController: ExchangeListDisplaying) {
        self.viewController = viewController
    }
    
    // MARK: Properties
    
    // MARK: Internal Funcitons
}

private extension ExchangeListPresenter {
    // MARK: Private Funcitons
}

extension ExchangeListPresenter: ExchangeListPresenting {
    // MARK: Interacting Funcitons
    func present(exchanges: [Exchange]) {
        viewController.display(exchanges: exchanges)
    }
    
    func present(exchangeIconPaths: [ExchangeIconPath]) {
        viewController.update(exchangeIconList: exchangeIconPaths)
    }
    
    func presentError() {
        
    }
    
    func presentLoad() {
        viewController.displayLoading()
    }
    
    func hideLoad() {
        
    }
}
