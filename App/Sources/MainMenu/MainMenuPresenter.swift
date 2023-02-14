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
        let title = MainAppStrings.title
        viewController?.display(title: title)
        
        let nextButtonTitle = MainAppStrings.exchangeList
        viewController?.display(nextButtonTitle: nextButtonTitle)
    }
}
