import UIKit
import MBUI

protocol ExchangeDetailPresenting {
    // Change Presentated Info functions
    func present(exchange: Exchange)
    func present(imageData: Data)
}

final class ExchangeDetailPresenter {
	// MARK: VIP Properties
    weak var viewController: ExchangeDetailDisplaying?
}

private extension ExchangeDetailPresenter {
    func string(from date: Date?) -> String? {
        guard let date = date else {
            return nil
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd / MM / yyyy"
        return dateFormatter.string(from: date)
    }
    
    func string(from double: Double) -> String? {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        formatter.maximumIntegerDigits = 6
        return formatter.string(from: .init(floatLiteral: double))
    }
    
    func url(from string: String) -> URL? {
        URL(string: string)
    }
}

extension ExchangeDetailPresenter: ExchangeDetailPresenting {
    func present(exchange: Exchange) {
        viewController?.display(navigationTitle: exchange.name)
        viewController?.display(title: exchange.exchangeId)
        viewController?.display(subtitleTop: string(from: exchange.dateStart))
        viewController?.display(subtitleBottom: string(from: exchange.dateEnd))
        viewController?.display(volume1Hour: string(from: exchange.volume1HourUsd))
        viewController?.display(volume1Day: string(from: exchange.volume1DayUsd))
        viewController?.display(volume1Month: string(from: exchange.volume1MonthUsd))
    }
    
    func present(imageData: Data) {
        guard let image = UIImage(data: imageData) else {
            viewController?.display(image: .AppImages.currency)
            return
        }
        
        viewController?.display(image: image)
    }
}
