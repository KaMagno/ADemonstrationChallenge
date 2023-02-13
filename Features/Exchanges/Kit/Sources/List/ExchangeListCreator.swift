import UIKit

public enum ExchangeListCreator {
    public static func create() -> UIViewController {
        let router = ExchangeListRouter()
        let presenter = ExchangeListPresenter()
        let exchangeListWorker = ExchangeListWorker()
        let interactor = ExchangeListInteractor(presenter: presenter,
                                                exchangeListWorker: exchangeListWorker)
        let viewController = ExchangeListViewController()
        viewController.router = router
        viewController.interactor = interactor
        
        presenter.viewController = viewController
        
        return viewController
    }
}
