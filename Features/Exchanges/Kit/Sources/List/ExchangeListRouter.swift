import UIKit

protocol ExchangeListRouting: AnyObject {
    func goToDetail(with exchange:Exchange, andImagePath imagePath: String?)
}

final class ExchangeListRouter {
    // MARK: VIP Properties
    weak var viewController: UIViewController?
}

extension ExchangeListRouter: ExchangeListRouting {
    func goToDetail(with exchange: Exchange, andImagePath imagePath: String?) {
        let detailView = ExchangeDetailCreator.create(with: exchange, andImagePath: imagePath)
        viewController?.navigationController?.pushViewController(detailView, animated: true)
    }
}
