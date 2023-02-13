import UIKit
import Commons

final class ExchangeTableViewCell: UITableViewCell {
    // MARK: - Identifier
    static let identifier = String(describing: ExchangeTableViewCell.self)
    
    // MARK: - ExchangeCellViewController
    // MARK: Internal Properties
    var imageSessionTask: URLSessionDataTask?
    
    // MARK: View Properties
    private lazy var exchangeImageView: UIImageView = {
        let defaultImage = UIImage(named: "default")
        let imageView = UIImageView(image: defaultImage)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18.0)
        label.text = "Title"
        return label
    }()
    
    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12.0)
        label.textColor = .lightGray
        label.text = "Subtitle"
        return label
    }()
    
    private lazy var valueLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14.0)
        label.textColor = .darkGray
        label.textAlignment = .right
        label.text = "$ 12,000.38"
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
        let defaultImage = UIImage(systemName: "coloncurrencysign.circle")
        exchangeImageView.image = defaultImage
    }
    
    func loadImage(from path: String) {
        guard let url = URL(string: path) else { return }
        
        let session = URLSession.init(configuration: .default)
        session.configuration.requestCachePolicy = .returnCacheDataElseLoad
        imageSessionTask = session.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error downloading image: \(error.localizedDescription)")
                return
            }
            
            guard let data = data,
                    let image = UIImage(data: data) else { return }
            
            DispatchQueue.main.async {
                self.exchangeImageView.image = image
            }
        }
        
        imageSessionTask?.resume()
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
