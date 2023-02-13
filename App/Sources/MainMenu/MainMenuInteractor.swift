import UIKit

protocol MainMenuInteracting {
    func requestData()
}

final class MainMenuInteractor {
    // MARK: VIP Properties
    let presenter: MainMenuPresenting
    
    // MARK: Init
    init(presenter: MainMenuPresenting) {
        self.presenter = presenter
    }
}

extension MainMenuInteractor: MainMenuInteracting {
    // MARK: Interacting Funcitons
    func requestData() {
        presenter.presentMainInfo()
    }
}
