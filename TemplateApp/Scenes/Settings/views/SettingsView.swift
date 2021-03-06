import RxCocoa
import RxSwift
import UIKit

protocol SettingViewType: onTapNextView, LoadingProcessView where Self: UIView { }

class SettingsView: UIView, SettingViewType {
    private let nextText: String = "Home"

    let onTapNext: Signal<Void>
    private let tapNext: PublishRelay<Void>

    let disposeBag = DisposeBag()

    lazy var welcomeLabel: UILabel = {
        let label = UILabel()

        return label
    }()

    lazy var loadingView = loadingIndicator

    var loadingViews: [UIView] = []

    private lazy var nextButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 37)
        button.clipsToBounds = true
        button.layer.cornerRadius = 20

        return button
    }()

    convenience init() {
        self.init(frame: .zero)
    }

    override init(frame: CGRect) {
        tapNext = PublishRelay<Void>()
        onTapNext = tapNext.asSignal()

        super.init(frame: frame)

        configure()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Configure views
private extension SettingsView {
    func configure() {
        backgroundColor = .red

        configureWelcomeLabel()
        configureLoginButton()
        configureLoadingView()

        setupBindings()
    }

    func configureWelcomeLabel() {
        addSubview(welcomeLabel)
        welcomeLabel.snp.makeConstraints { maker in
            maker.centerX.equalToSuperview()
            maker.centerY.equalToSuperview().offset(50)
        }
    }

    func configureLoginButton() {
        addSubview(nextButton)
        nextButton.snp.makeConstraints { maker in
            maker.top.equalToSuperview().offset(50)
            maker.trailing.equalToSuperview().inset(30)
            maker.height.width.equalTo(40)
        }
    }
}

// MARK: Bindings
extension SettingsView {
    private func setupBindings() {
        nextButton.rx.tap
            .bind(to: tapNext)
            .disposed(by: disposeBag)

        nextButton.rx.tap
            .map({ _ -> CGFloat in 0.75 })
            .bind(to: nextButton.rx.alpha)
            .disposed(by: disposeBag)

        nextButton.rx.tap
            .delay(.milliseconds(250), scheduler: MainScheduler.instance)
            .map({ _ -> CGFloat in 1 })
            .bind(to: nextButton.rx.alpha)
            .disposed(by: disposeBag)
    }
}
