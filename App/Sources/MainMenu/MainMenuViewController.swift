import Commons
import UI
import SnapKit
import UIKit

protocol MainMenuDisplaying: AnyObject {
    func display(title: String)
    func display(nextButtonTitle: String)
}

class MainMenuViewController: UIViewController {
    // MARK: VIP Properties
    
    var interactor: MainMenuInteracting?
    var router: MainMenuRouting?
    
    // MARK: View Properties
    private lazy var nextButton: UIButton = {
        let action = UIAction { action in
            self.didTouchNextButton()
        }
        let button = UIButton(primaryAction: action)
        button.titleLabel?.textColor = .AppColor.primary
        button.titleLabel?.font = .title
        return button
    }()
    
    // MARK: init
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) { nil }
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewCoding()
        interactor?.requestData()
    }
}

private extension MainMenuViewController {
    func didTouchNextButton() {
        router?.goToExchangeList()
    }
}

extension MainMenuViewController: ViewCoding {
    func setupViewHierarchy() {
        view.addSubview(nextButton)
    }
    
    func setupConstratins() {
        nextButton.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    func setupAddtionalContent() {
        view.backgroundColor = .AppColor.bright
    }
}

extension MainMenuViewController: MainMenuDisplaying {
    func display(title: String) {
        self.title = title
    }
    
    func display(nextButtonTitle: String) {
        nextButton.setTitle(nextButtonTitle, for: .normal)
    }
}
