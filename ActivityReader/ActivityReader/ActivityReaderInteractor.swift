import Foundation
import CSV

protocol ActivityReaderBusinessLogic: AnyObject {
    func toggleAcceleration()
}

final class ActivityReaderInteractor: ActivityReaderBusinessLogic {
    
    public var presenter: ActivityReaderPresentationLogic?
    private var accelerometerService = ActivityReaderService()
    private var storageService = StorageService()
    
    private var currentState: TimerState = .stop {
        didSet {
            self.presenter?.displayButtonImage(name: self.currentState.imageName())
            
            switch self.currentState {
            
            case .start:
                self.accelerometerService.startAccelerometer(updatingData: { [weak self] data in
                    self?.presenter?.display(acceleration: data.acc)
                    self?.data.append(data)
                })
                
            case .stop:
                self.presenter?.showAlert(saveCompletion: { [weak self] text in
                    self?.save(text: text)
                }, cancelCompletion: { [weak self] in
                    self?.removeData()
                })
                self.accelerometerService.stopAccelerometer()
            }
        }
    }
    private var data = [MotionData]()
    private var accelerometerData = [Vector]()
    private var gyroscopeData = [Vector]()
    
    func toggleAcceleration() {
        currentState = currentState.opposite()
    }
    
    // MARK: - Private Methods
    
    private func save(text: String) {
        self.storageService.save(data, name: text)
        
        let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let items = [url.appendingPathComponent("\(text).csv")]
        self.presenter?.showActivityViewController(with: items)
        
        self.removeData()
    }
    
    private func removeData() {
        self.accelerometerData = []
        self.gyroscopeData = []
    }
}
