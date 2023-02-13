import UIKit

protocol MainMenuPresenting {
    func presentMainInfo()
}

final class MainMenuPresenter {
    weak var viewController: MainMenuDisplaying?
}

extension MainMenuPresenter: MainMenuPresenting {
    // MARK: Interacting Funcitons
    func presentMainInfo() {
        let title = "MB Challenge"
        viewController?.display(title: title)
        
        let nextButtonTitle = "Listing Exchanges"
        viewController?.display(nextButtonTitle: nextButtonTitle)
    }
}
