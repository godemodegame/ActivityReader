import UIKit

protocol ActivityReaderPresentationLogic {
    func presentData(response: ActivityReader.Model.Response.ResponseType)
}

class ActivityReaderPresenter: ActivityReaderPresentationLogic {
    weak var viewController: ActivityReaderDisplayLogic?
    
    func presentData(response: ActivityReader.Model.Response.ResponseType) {
        switch response {
        case .displayAcceleration(let data): self.viewController?.displayData(viewModel: .changeAcceleration(data: data))
        case .changeButton(let type): self.viewController?.displayData(viewModel: .changeButton(image: UIImage(systemName: type.rawValue)))
        case .showAlert: self.viewController?.displayData(viewModel: .showAlert)
        }
    }
    
}
