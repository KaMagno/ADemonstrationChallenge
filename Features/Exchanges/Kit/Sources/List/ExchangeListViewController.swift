import Commons
import MBNetwork
import MBUI
import SnapKit
import UIKit

protocol ExchangeListDisplaying {
    func display(exchanges: [Exchange])
    func update(exchangeIconList: [ExchangeIconPath])
    func displayError()
    func displayLoading()
    func undisplayLoading()
}

class ExchangeListViewController: UIViewController {
    // MARK: Constatns
    
    private enum Constants {
        static let cellSize: CGFloat = 80.0
    }
    
    // MARK: VIP Properties
    
    weak var interactor: ExchangeListInteracting?
    var router: ExchangeListRouting?
    
    // MARK: View Properties
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        // TODO: Register Cell
        tableView.register(ExchangeTableViewCell.self,
                           forCellReuseIdentifier: ExchangeTableViewCell.identifier)
        return tableView
    }()
    
    // MARK: Private Propeties
    private var exchanges: [Exchange] = []
    private var exchangeIconPaths: [String: String] = [:]
    
    // MARK: Init
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) { nil }
    
    // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewCoding()
        requestDataList()
    }
}

// MARK: Private Functions
private extension ExchangeListViewController {
    func requestDataList() {
        interactor?.requestExchangeListData()
    }
}

// MARK: - Implementations

// MARK: ViewCoding Implementation
extension ExchangeListViewController: ViewCoding {
    func setupViewHierarchy() {
        view.addSubview(tableView)
    }
    
    func setupConstratins() {
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func setupAddtionalContent() {
        tableView.dataSource = self
        tableView.delegate = self
        view.backgroundColor = .AppColor.bright
    }
}

// MARK: TableView Protocols Implementation
extension ExchangeListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return exchanges.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ExchangeTableViewCell.identifier,
                                                       for: indexPath) as? ExchangeTableViewCell else {
            return .init()
        }
        
        let exchange = exchanges[indexPath.row]
        cell.configure(viewModel: .init(exchange: exchange))
        
        if let path = exchangeIconPaths[exchange.exchangeId] {
            cell.configure(imagePath: path)
        }
        
        return cell
    }
}

extension ExchangeListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        Constants.cellSize
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let cell = cell as? ExchangeTableViewCell,
           let task = cell.imageSessionTask,
           let visibleIndexPaths = tableView.indexPathsForVisibleRows,
           visibleIndexPaths.contains(indexPath) == false {
            task.cancel()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let exchange = exchanges[indexPath.row]
        let imagePath = exchangeIconPaths[exchange.exchangeId]
        
        router?.goToDetail(with: exchange,
                           andImagePath: imagePath)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: VIP View Implementation
extension ExchangeListViewController: ExchangeListDisplaying {
    func display(exchanges: [Exchange]) {
        self.exchanges = exchanges
        tableView.reloadData()
    }
    
    func update(exchangeIconList: [ExchangeIconPath]) {
        exchangeIconPaths = exchangeIconList.reduce(into: [:], { partialResult, exchangeIconPath in
            partialResult[exchangeIconPath.exchangeId] = exchangeIconPath.path
        })
    }
    
    func displayError() {
        //TODO: Replace text for Localizable Itens
        let alert = UIAlertController(title: "Error",
                                      message: "Could not load informatiokn",
                                      preferredStyle: .alert)
        present(alert, animated: true)
    }
    
    func displayLoading() {
        //
    }
    
    func undisplayLoading() {
        //
    }
}
