import Foundation

protocol ActivityReaderConfiguratorLogic: AnyObject {
    func configure(with viewController: ActivityReaderViewController)
}

final class ActivityReaderConfigurator: ActivityReaderConfiguratorLogic {
    func configure(with viewController: ActivityReaderViewController) {
        let interactor            = ActivityReaderInteractor()
        let presenter             = ActivityReaderPresenter()
        viewController.interactor = interactor
        interactor.presenter      = presenter
        presenter.viewController  = viewController
    }
}
