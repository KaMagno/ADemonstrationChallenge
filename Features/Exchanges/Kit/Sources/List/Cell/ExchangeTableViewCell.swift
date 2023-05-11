import UIKit
import ACNetwork
import UI

final class ExchangeTableViewCell: UITableViewCell {
    // MARK: - Identifier
    static let identifier = String(describing: ExchangeTableViewCell.self)
    
    // MARK: - ExchangeCellViewController
    // MARK: Private Properties
    private var viewModel: ViewModel?
    
    // MARK: Internal Properties
    private(set) var imageSessionTask: URLSessionDataTask?
    
    // MARK: View Properties
    private lazy var exchangeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = .AppImages.currency
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .title
        label.textColor = .AppColor.primary
        return label
    }()
    
    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = .xSmall
        label.textColor = .lightGray
        label.textColor = .AppColor.dark
        return label
    }()
    
    private lazy var valueLabel: UILabel = {
        let label = UILabel()
        label.font = .small
        label.textColor = .AppColor.secondary
        label.textAlignment = .right
        return label
    }()
    
    private lazy var middleVerticalStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            titleLabel,
            subtitleLabel
        ])
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.spacing = 8.0
        return stackView
    }()
    
    private lazy var horizontalStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            exchangeImageView,
            middleVerticalStackView,
            valueLabel
        ])
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.spacing = 16.0
        return stackView
    }()
    
    // MARK: Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViewCoding()
    }
    
    required init?(coder aDecoder: NSCoder) { nil }
    
    // MARK: View lifecycle
    override func prepareForReuse() {
        super.prepareForReuse()
        
        setDefaultImage()
    }
    
    // MARK: Internal Funcitons
    func configure(viewModel: ViewModel) {
        self.viewModel = viewModel
        
        titleLabel.text = viewModel.title
        subtitleLabel.text = viewModel.subtitle
        valueLabel.text = viewModel.value
    }
    
    func configure(imagePath: String) {
        loadImage(from: imagePath)
    }
    
    func cancelImageDownload() {
        imageSessionTask?.cancel()
    }
}

private extension ExchangeTableViewCell {
    // MARK: Private Funcitons
    func setDefaultImage() {
        exchangeImageView.image = .AppImages.currency
    }
    
    func loadImage(from imagePath: String) {
        guard let url = URL(string: imagePath) else { return }
        
        imageSessionTask = ImageSession.shared.session.dataTask(with: url) {[weak self] data, response, error in
            guard let self = self else { return }
            if let error = error {
                print("Error downloading image: \(error.localizedDescription)")
                return
            }
            
            DispatchQueue.main.async {
                self.handle(data: data)
            }
        }
        
        imageSessionTask?.resume()
    }
    
    func handle(data: Data?) {
        guard let data,
              let exchangeImage = UIImage(data: data) else {
            return
        }
        
        exchangeImageView.image = exchangeImage
    }
}

extension ExchangeTableViewCell: ViewCoding {
    func setupViewHierarchy() {
        contentView.addSubview(horizontalStackView)
    }
    
    func setupConstratins() {
        exchangeImageView.snp.makeConstraints { make in
            make.height.equalTo(exchangeImageView.snp.width)
            make.height.equalTo(48.0)
        }
        horizontalStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(16.0)
        }
    }
    
    func setupAddtionalContent() {
        
    }
}
