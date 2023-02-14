import UIKit
import MBUI
import SnapKit

final class ExchangeEmptyListView: UIView {
    // MARK: View Properties
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .xLarge
        label.textColor = .AppColor.terciary
        label.textAlignment = .center
        label.text = ExchangesStrings.exhangeEmptyList
        return label
    }()
    
    // MARK: Init
    init() {
        super.init(frame: .zero)
        setupViewCoding()
    }
    
    required init?(coder: NSCoder) { nil }
}

extension ExchangeEmptyListView: ViewCoding {
    func setupViewHierarchy() {
        addSubview(titleLabel)
    }
    
    func setupConstratins() {
        titleLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}

