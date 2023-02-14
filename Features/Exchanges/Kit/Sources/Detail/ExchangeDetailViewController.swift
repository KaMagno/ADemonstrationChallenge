import Commons
import MBUI
import SnapKit
import UIKit

protocol ExchangeDetailDisplaying: AnyObject {
    func display(image: UIImage)
    func display(navigationTitle: String?)
    func display(title: String?)
    func display(subtitleTop: String?)
    func display(subtitleBottom: String?)
    func display(website: URL?)
    func display(volume1Hour: String?)
    func display(volume1Day: String?)
    func display(volume1Month: String?)
}

final class ExchangeDetailViewController: UIViewController {
    // MARK: VIP Properties
    var interactor: ExchangeDetailInteracting?
    
    // MARK: UI Properties
    private lazy var logoImageView: UIImageView = {
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
    
    private lazy var startDateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.medium
        return label
    }()
    
    private lazy var startEndLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.medium
        return label
    }()
    
    private lazy var volume1HourLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.medium
        label.text = ExchangesStrings.volume1hour
        return label
    }()
    
    private lazy var volume1DayLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.medium
        label.text = ExchangesStrings.volume1Day
        return label
    }()
    
    private lazy var volume1MonthLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.medium
        label.text = ExchangesStrings.volume1Month
        return label
    }()
    
    private lazy var volume1HourValueLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.medium
        label.textColor = .AppColor.primary
        return label
    }()
    
    private lazy var volume1DayValueLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.medium
        label.textColor = .AppColor.primary
        return label
    }()
    
    private lazy var volume1MonthValueLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.medium
        label.textColor = .AppColor.primary
        return label
    }()
    
    private lazy var volumesView: UIView = {
        let view = UIView()
        view.backgroundColor = .AppColor.terciary
        view.layer.cornerRadius = CornerRadius.medium
        return view
    }()
    
    // MARK: Init
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) { nil }
    
    // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewCoding()
        requestData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        interactor?.requestImage()
        setupNavigationTitle()
    }
    
    // MARK: Internal Funcitons
}

private extension ExchangeDetailViewController {
    // MARK: Private Funcitons
    func requestData() {
        interactor?.requestData()
    }
    
    func setupNavigationTitle() {
        navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.largeTitleTextAttributes = [
            .foregroundColor: UIColor.AppColor.dark
        ]
    }
}

extension ExchangeDetailViewController: ViewCoding {
    func setupViewHierarchy() {
        volumesView.addSubview(volume1HourLabel)
        volumesView.addSubview(volume1DayLabel)
        volumesView.addSubview(volume1MonthLabel)
        volumesView.addSubview(volume1HourValueLabel)
        volumesView.addSubview(volume1DayValueLabel)
        volumesView.addSubview(volume1MonthValueLabel)
        view.addSubview(logoImageView)
        view.addSubview(titleLabel)
        view.addSubview(startDateLabel)
        view.addSubview(startEndLabel)
        view.addSubview(volumesView)
    }
    
    func setupConstratins() {
        makeVolumeViewConstraints()
        makeMainViewConstraints()
    }
    
    private func makeVolumeViewConstraints() {
        volume1HourLabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(Margins.medium)
        }
        volume1MonthLabel.snp.makeConstraints { make in
            make.top.equalTo(volume1HourLabel.snp.bottom).offset(Margins.small)
            make.leading.equalTo(volume1HourLabel.snp.leading)
        }
        volume1DayLabel.snp.makeConstraints { make in
            make.top.equalTo(volume1MonthLabel.snp.bottom).offset(Margins.small)
            make.leading.equalTo(volume1MonthLabel.snp.leading)
            make.bottom.equalToSuperview().offset(-Margins.medium)
        }
        volume1HourValueLabel.snp.makeConstraints { make in
            make.top.bottom.equalTo(volume1HourLabel)
            make.leading.greaterThanOrEqualTo(volume1HourLabel.snp.trailing).offset(Margins.small).priority(.low)
            make.trailing.equalToSuperview().offset(-Margins.medium)
        }
        volume1DayValueLabel.snp.makeConstraints { make in
            make.top.bottom.equalTo(volume1DayLabel)
            make.leading.greaterThanOrEqualTo(volume1DayLabel.snp.trailing).offset(Margins.small).priority(.low)
            make.trailing.equalToSuperview().offset(-Margins.medium)
        }
        volume1MonthValueLabel.snp.makeConstraints { make in
            make.top.bottom.equalTo(volume1MonthLabel)
            make.leading.greaterThanOrEqualTo(volume1MonthLabel.snp.trailing).offset(Margins.small).priority(.low)
            make.trailing.equalToSuperview().offset(-Margins.medium)
        }
    }
    
    private func makeMainViewConstraints() {
        logoImageView.snp.makeConstraints { make in
            make.topMargin.leading.equalToSuperview().offset(Margins.large)
            make.width.equalTo(logoImageView.snp.height)
            make.height.equalTo(ImageSize.large)
        }
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(logoImageView.snp.top)
            make.leading.equalTo(logoImageView.snp.trailing).offset(Margins.medium)
        }
        startDateLabel.snp.makeConstraints { make in
            make.top.greaterThanOrEqualTo(titleLabel.snp.bottom).offset(Margins.small).priority(.low)
            make.leading.equalTo(titleLabel.snp.leading)
        }
        startEndLabel.snp.makeConstraints { make in
            make.top.equalTo(startDateLabel.snp.bottom).offset(Margins.small)
            make.leading.equalTo(startDateLabel.snp.leading)
            make.bottom.equalTo(logoImageView.snp.bottom)
        }
        volumesView.snp.makeConstraints { make in
            make.top.equalTo(logoImageView.snp.bottom).offset(Margins.xLarge)
            make.leading.equalToSuperview().offset(Margins.medium)
            make.trailing.equalToSuperview().offset(-Margins.medium)
            make.height.equalTo(120.0).priority(.low)
        }
    }
    
    func setupAddtionalContent() {
        view.backgroundColor = .AppColor.bright
        volumesView.backgroundColor = .AppColor.terciary
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}

extension ExchangeDetailViewController: ExchangeDetailDisplaying {
    func display(image: UIImage) {
        logoImageView.image = image
    }
    
    func display(navigationTitle: String?) {
        title = navigationTitle
    }
    
    func display(title: String?) {
        titleLabel.text = title
    }
    
    func display(subtitleTop: String?) {
        startDateLabel.text = subtitleTop
    }
    
    func display(subtitleBottom: String?) {
        startEndLabel.text = subtitleBottom
    }
    
    func display(website: URL?) {
        //TODO: Add the Website support
    }
    
    func display(volume1Hour: String?) {
        volume1HourValueLabel.text = volume1Hour
    }
    
    func display(volume1Day: String?) {
        volume1DayValueLabel.text = volume1Day
    }
    
    func display(volume1Month: String?) {
        volume1MonthValueLabel.text = volume1Month
    }
    
    
}
