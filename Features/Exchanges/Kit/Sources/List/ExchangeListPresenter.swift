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
    weak var viewController: ExchangeListDisplaying?
}

extension ExchangeListPresenter: ExchangeListPresenting {
    // MARK: Interacting Funcitons
    func present(exchanges: [Exchange]) {
        viewController?.display(exchanges: exchanges)
    }
    
    func present(exchangeIconPaths: [ExchangeIconPath]) {
        viewController?.update(exchangeIconList: exchangeIconPaths)
    }
    
    func presentError() {
        viewController?.displayError()
    }
    
    func presentLoad() {
        viewController?.displayLoading()
    }
    
    func hideLoad() {
        viewController?.undisplayLoading()
    }
}
