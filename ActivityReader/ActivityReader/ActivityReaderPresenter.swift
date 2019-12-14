import UIKit

protocol ActivityReaderPresentationLogic {
    func display(acceleration: Vector)
    func displayButtonImage(name: String)
    func showAlert()
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
    
    func showAlert() {
        self.viewController?.showAlert()
    }
    
    func showActivityViewController(with items: [URL]) {
        self.viewController?.showActivityViewController(with: items)
    }
}
