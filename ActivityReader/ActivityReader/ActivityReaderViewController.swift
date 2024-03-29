import UIKit

protocol ActivityReaderDisplayLogic: AnyObject {
    func display(acceleration: Vector)
    func changeButton(image: UIImage?)
    func showAlert(saveCompletion: @escaping (String) -> Void, cancelCompletion: @escaping () -> Void)
    func showActivityViewController(with items: [URL])
}

final class ActivityReaderViewController: UIViewController {
    
    let configurator: ActivityReaderConfiguratorLogic = ActivityReaderConfigurator()
    var interactor: ActivityReaderBusinessLogic?
    
    // MARK: - IBOutlets
    
    @IBOutlet private weak var startButton: UIButton!
    
    @IBOutlet private weak var accelerometerXLabel: UILabel!
    @IBOutlet private weak var accelerometerYLabel: UILabel!
    @IBOutlet private weak var accelerometerZLabel: UILabel!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configurator.configure(with: self)
    }
    
    // MARK: - Private Actions
    
    @IBAction private func startButtonTapped(_ sender: UIButton) {
        self.interactor?.toggleAcceleration()
    }
}

// MARK: - ActivityReaderDisplayLogic

extension ActivityReaderViewController: ActivityReaderDisplayLogic {
    func display(acceleration: Vector) {
        self.accelerometerXLabel.text = "acc x: \(acceleration.x)"
        self.accelerometerYLabel.text = "acc y: \(acceleration.y)"
        self.accelerometerZLabel.text = "acc z: \(acceleration.z)"
    }
    
    func changeButton(image: UIImage?) {
        self.startButton.setBackgroundImage(image, for: .normal)
    }
    
    func showAlert(saveCompletion: @escaping (String) -> Void, cancelCompletion: @escaping () -> Void) {
        let alertController = UIAlertController(title: "Done", message: "Note:", preferredStyle: .alert)
        alertController.addTextField(configurationHandler: nil)
        alertController.addAction(UIAlertAction(title: "Save", style: .default, handler: { _ in
            if let text = alertController.textFields?.first?.text {
                saveCompletion(text)
            }
        }))
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { _ in
            cancelCompletion()
        }))
        self.present(alertController, animated: true, completion: nil)
    }
    
    func showActivityViewController(with items: [URL]) {
        let activityController = UIActivityViewController(activityItems: items, applicationActivities: nil)
        self.present(activityController, animated: true)
    }
}
