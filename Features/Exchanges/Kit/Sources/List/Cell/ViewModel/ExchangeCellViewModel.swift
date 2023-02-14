import Foundation

extension ExchangeTableViewCell {
    struct ViewModel {
        // MARK: Computed Variables
        var title: String {
            exchange.name
        }
        var subtitle: String {
            exchange.exchangeId
        }
        var value: String? {
            let numberFormatter = NumberFormatter()
            numberFormatter.numberStyle = .currency
            numberFormatter.maximumFractionDigits = 2
            numberFormatter.currencySymbol = "$"
            numberFormatter.maximumIntegerDigits = 6
            return numberFormatter.string(from: .init(floatLiteral: exchange.volume1DayUsd))
        }
        
        // MARK: Internal Variables
        let exchange: Exchange
        
        init(exchange: Exchange) {
            self.exchange = exchange
        }
    }
}
