import UIKit
import RxFlow
import RxSwift
import RxCocoa
import SnapKit

final class TopBarViewController: UIViewController, Stepper {
    let steps = PublishRelay<Step>()

    var detailBarView: TopBarViewType!
    var closeStep: Step!
    var backStep: Step!

    private let disposeBag = DisposeBag()
    static let height = 50

    @discardableResult
    func configured() -> Self {
        configureView()
        setupBindings()
        
        return self
    }
}

//MARK: UI
private extension TopBarViewController {
    func configureView() {
        view.snp.makeConstraints { maker in
            maker.height.equalTo(TopBarViewController.height)
        }
        view.addSubview(detailBarView)
        detailBarView.snp.makeConstraints { $0.edges.equalToSuperview() }
    }
}

//MARK: Bindings
private extension TopBarViewController {
    func setupBindings() {
        detailBarView.viewModel.onClose
            .emit(onNext: { [unowned self] in steps.accept(closeStep) })
            .disposed(by: disposeBag)
        
        detailBarView.viewModel.onBack
            .emit(onNext: { [unowned self] in steps.accept(backStep) })
            .disposed(by: disposeBag)
    }
}

