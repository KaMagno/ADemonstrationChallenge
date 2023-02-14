import UIKit

protocol ExchangeListInteracting {
    func requestExchangeListData()
    func requestExchangeIconPathList()
}

final class ExchangeListInteractor {
    // MARK: VIP Properties
    let presenter: ExchangeListPresenting
    
    // MARK: Private Properties
    private let exchangeListWorker: ExchangeListWorking
    
    // MARK: Init
    init(presenter: ExchangeListPresenting, exchangeListWorker: ExchangeListWorking) {
        self.presenter = presenter
        self.exchangeListWorker = exchangeListWorker
        
        self.requestExchangeIconPathList()
    }
    
    // MARK: Internal Funcitons
}

extension ExchangeListInteractor: ExchangeListInteracting {
    // MARK: Interacting Funcitons
    func requestExchangeListData() {
        presenter.presentLoad()
        exchangeListWorker.fetchExchangeList { [self] result in
            switch result {
            case .success(let exchanges):
                self.presenter.hideLoad()
                self.presenter.present(exchanges: exchanges)
            case .failure:
                self.presenter.presentError()
                //If we had a Logger. It would be added here.
                //Or a switch to show different kinds of error's feedback on screen.
            }
        }
    }
    
    func requestExchangeIconPathList() {
        exchangeListWorker.fetchExchangeIconPaths { result in
            switch result {
            case .success(let exchangeIconPaths):
                self.presenter.present(exchangeIconPaths: exchangeIconPaths)
            case .failure:
                self.presenter.presentError()
            }
        }
    }
}
