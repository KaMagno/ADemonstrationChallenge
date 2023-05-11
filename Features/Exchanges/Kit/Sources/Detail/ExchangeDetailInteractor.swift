import UIKit
import ACNetwork

protocol ExchangeDetailInteracting {
    // Bussiness Functions Logic
    func requestData()
    func requestImage()
}

final class ExchangeDetailInteractor {
    // MARK: VIP Properties
    private let presenter: ExchangeDetailPresenting

    // MARK: Properties
    private lazy var worker: ExchangeImageWorker = {
        let service = Service(session: ImageSession.shared.session)
        return .init(service: service)
    }()
    
    private let exchange: Exchange
    private let imagePath: String?

	// MARK: Init
    init(presenter: ExchangeDetailPresenting,
         exchange: Exchange,
         imagePath: String?) {
		self.presenter = presenter
        self.exchange = exchange
        self.imagePath = imagePath
	}
}

private extension ExchangeDetailInteractor {
    func requestImage(fromPath path: String) {
        worker.fetchImage(fromPath: path) { result in
            switch result {
            case .success(let imageData):
                self.presenter.present(imageData: imageData)
            case .failure(let error):
                debugPrint("--- ! Errror ! ---\n\(error)")
            }
        }
    }
}

extension ExchangeDetailInteractor: ExchangeDetailInteracting {
    // MARK: Interacting Funcitons
    func requestData() {
        presenter.present(exchange: exchange)
    }
    func requestImage() {
        if let imagePath = imagePath {
            requestImage(fromPath: imagePath)
        }
    }
}
