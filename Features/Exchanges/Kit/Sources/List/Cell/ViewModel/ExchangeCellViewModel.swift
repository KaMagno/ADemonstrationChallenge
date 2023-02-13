import UIKit

extension ExchangeTableViewCell {
    // MARK: - ExchangeCellViewController.ViewModel
    struct ViewModel {
        let title: String
        let subtitle: String
        let value: String?
        
        init(exchange: Exchange) {
            title = exchange.name
            subtitle = exchange.exchangeId
            
            let numberFormatter = NumberFormatter()
            numberFormatter.numberStyle = .currency
            numberFormatter.maximumFractionDigits = 2
            numberFormatter.currencySymbol = "$"
            value = numberFormatter.string(from: .init(floatLiteral: exchange.volume1DayUsd))
        }
    }
}
