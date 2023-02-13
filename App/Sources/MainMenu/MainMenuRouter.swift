import UIKit
import Exchanges

protocol MainMenuRouting {
    func goToExchangeList()
}

final class MainMenuRouter {
    // MARK: VIP Properties
    weak var viewController: MainMenuViewController?
}

extension MainMenuRouter: MainMenuRouting {
    // MARK: Routing Functions
    func goToExchangeList() {
        let nextViewController = ExchangeListCreator.create()
        if let navigationViewController = viewController?.navigationController {
            navigationViewController.pushViewController(nextViewController, animated: true)
            return
        }
        nextViewController.modalPresentationStyle = .overFullScreen
        viewController?.present(nextViewController, animated: true)
    }
}
