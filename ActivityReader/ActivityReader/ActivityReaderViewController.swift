import UIKit

protocol ActivityReaderDisplayLogic: AnyObject {
    func display(acceleration: Vector)
    func changeButton(image: UIImage?)
    func showAlert()
    func showActivityViewController(with items: [URL])
}

final class ActivityReaderViewController: UIViewController {
    
    let configurator: ActivityReaderConfiguratorLogic = ActivityReaderConfigurator()
    var interactor: ActivityReaderBusinessLogic?
    
    // MARK: IBOutlets & IBActions
    
    @IBOutlet weak var startButton: UIButton!
    
    @IBOutlet weak var accelerometerXLabel: UILabel!
    @IBOutlet weak var accelerometerYLabel: UILabel!
    @IBOutlet weak var accelerometerZLabel: UILabel!
    
    @IBAction func startButtonTapped(_ sender: UIButton) {
        self.interactor?.toggleAcceleration()
    }
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configurator.configure(with: self)
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
    
    func showAlert() {
        let alertController = UIAlertController(title: "Done", message: "Note:", preferredStyle: .alert)
        alertController.addTextField(configurationHandler: nil)
        alertController.addAction(UIAlertAction(title: "Save", style: .default, handler: { [weak self] _ in
            if let text = alertController.textFields?.first?.text {
                self?.interactor?.save(text: text)
            }
        }))
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { [weak self] _ in
            self?.interactor?.removeData()
        }))
        self.present(alertController, animated: true, completion: nil)
    }
    
    func showActivityViewController(with items: [URL]) {
        let activityController = UIActivityViewController(activityItems: items, applicationActivities: nil)
        self.present(activityController, animated: true)
    }
}
