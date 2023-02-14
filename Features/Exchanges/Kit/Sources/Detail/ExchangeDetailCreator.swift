import UIKit

enum ExchangeDetailCreator {
    /*
     Here I decided to pass the ImagePath beside the Image itself because
     the image might not be loaded. But if it is laoded it will load from cache.
     So it will no be requested twice
     **/
    static func create(with exchange: Exchange,
                       andImagePath imagePath: String?) -> UIViewController {
        let viewController = ExchangeDetailViewController()
        let presenter = ExchangeDetailPresenter()
        let interactor = ExchangeDetailInteractor(presenter: presenter,
                                                  exchange: exchange,
                                                  imagePath: imagePath)
        viewController.interactor = interactor
        presenter.viewController = viewController
        
        return viewController
    }
}
