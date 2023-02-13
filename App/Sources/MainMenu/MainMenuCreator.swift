import UIKit

public enum MainMenuCreator {
    public static func create() -> UIViewController {
        let router = MainMenuRouter()
        let presenter = MainMenuPresenter()
        let interactor = MainMenuInteractor(presenter: presenter)
        let viewController = MainMenuViewController()
        viewController.router = router
        viewController.interactor = interactor
        
        presenter.viewController = viewController
        router.viewController = viewController
        
        return viewController
    }
}

