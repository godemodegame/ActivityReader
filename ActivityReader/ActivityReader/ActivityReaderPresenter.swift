import UIKit

protocol ActivityReaderPresentationLogic: AnyObject {
    func display(acceleration: Vector)
    func displayButtonImage(name: String)
    func showAlert(saveCompletion: @escaping (String) -> Void, cancelCompletion: @escaping () -> Void)
    func showActivityViewController(with items: [URL])
}

final class ActivityReaderPresenter: ActivityReaderPresentationLogic {
    weak var viewController: ActivityReaderDisplayLogic?
    
    func display(acceleration: Vector) {
        self.viewController?.display(acceleration: acceleration)
    }
    
    func displayButtonImage(name: String) {
        self.viewController?.changeButton(image: UIImage(systemName: name))
    }
    
    func showAlert(saveCompletion: @escaping (String) -> Void, cancelCompletion: @escaping () -> Void) {
        self.viewController?.showAlert(saveCompletion: saveCompletion, cancelCompletion: cancelCompletion)
    }
    
    func showActivityViewController(with items: [URL]) {
        self.viewController?.showActivityViewController(with: items)
    }
}
