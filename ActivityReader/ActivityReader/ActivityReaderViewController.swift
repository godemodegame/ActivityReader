import UIKit

protocol ActivityReaderDisplayLogic: class {
    func displayData(viewModel: ActivityReader.Model.ViewModel.ViewModelData)
}

class ActivityReaderViewController: UIViewController, ActivityReaderDisplayLogic {
    
    private var interactor: ActivityReaderBusinessLogic?
    
    // MARK: IBOutlets & IBActions
    
    @IBOutlet weak var startButton: UIButton!
    
    @IBOutlet weak var accelerometerXLabel: UILabel!
    @IBOutlet weak var accelerometerYLabel: UILabel!
    @IBOutlet weak var accelerometerZLabel: UILabel!
    
    @IBAction func startButtonTapped(_ sender: UIButton) {
        self.interactor?.makeRequest(request: .checkActivityReader)
    }
    
    // MARK: Setup
    
    private func setup() {
        let viewController        = self
        let interactor            = ActivityReaderInteractor()
        let presenter             = ActivityReaderPresenter()
        viewController.interactor = interactor
        interactor.presenter      = presenter
        presenter.viewController  = viewController
    }
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
    }
    
    func displayData(viewModel: ActivityReader.Model.ViewModel.ViewModelData) {
        switch viewModel {
        case .changeAcceleration(let data):
            self.accelerometerXLabel.text = "acc x: \(data.x)"
            self.accelerometerYLabel.text = "acc y: \(data.y)"
            self.accelerometerZLabel.text = "acc z: \(data.z)"
        case .changeButton(let image): self.startButton.setBackgroundImage(image, for: .normal)
        case .showAlert: self.showAlert()
        }
    }
    
    private func showAlert() {
        let alertController = UIAlertController(title: "Done", message: "Note:", preferredStyle: .alert)
        alertController.addTextField(configurationHandler: nil)
        alertController.addAction(UIAlertAction(title: "Save", style: .default, handler: { [weak self] _ in
            if let text = alertController.textFields?.first?.text {
                self?.interactor?.makeRequest(request: .save(text))
            }
        }))
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { [weak self] _ in
            self?.interactor?.makeRequest(request: .delete)
        }))
        self.present(alertController, animated: true, completion: nil)
    }
}
