import Lottie
import SnapKit
import UIKit

public final class LoadingView: UIView {
    // MARK: Constants
    private enum Constants {
        static let fileName = "CryptoLoading"
        static let fileType = "json"
    }
    
    // MARK: Public Properties
    public var text: String? {
        get {
            titleLabel.text
        }
        set {
            titleLabel.text = newValue
        }
    }
    
    public var font: UIFont {
        get {
            titleLabel.font
        }
        set {
            titleLabel.font = newValue
        }
    }
    
    // MARK: Private View
    private lazy var loadingIcon: UIView = {
        guard let filePath = UIResources.bundle.path(forResource: Constants.fileName, ofType: Constants.fileType) else {
            return UIActivityIndicatorView(style: .large)
        }
        let loader = LottieAnimationView(filePath: filePath)
        loader.loopMode = .loop
        loader.contentMode = .scaleAspectFit
        loader.play()
        return loader
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .AppColor.primary
        label.font = .title
        label.text = UIStrings.loading
        return label
    }()
    
    private lazy var verticalStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [loadingIcon,
                                                   titleLabel])
        stack.axis = .vertical
        stack.distribution = .fillProportionally
        stack.spacing = Margins.small
        return stack
    }()
    
    public init() {
        super.init(frame: .zero)
        
        setupViewCoding()
    }
    
    required init?(coder: NSCoder) { nil }
}

extension LoadingView: ViewCoding {
    public func setupViewHierarchy() {
        addSubview(verticalStackView)
    }
    
    public func setupConstratins() {
        verticalStackView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}
