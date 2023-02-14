import UIKit

public enum ExchangeListCreator {
    public static func create() -> UIViewController {
        let viewController = ExchangeListViewController()
        let router = ExchangeListRouter()
        let presenter = ExchangeListPresenter()
        let exchangeListWorker = ExchangeListWorker()
        let interactor = ExchangeListInteractor(presenter: presenter,
                                                exchangeListWorker: exchangeListWorker)
        
        router.viewController = viewController
        viewController.router = router
        viewController.interactor = interactor
        presenter.viewController = viewController
        
        return viewController
    }
}
