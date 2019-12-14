import Foundation
import CSV

protocol ActivityReaderBusinessLogic: AnyObject {
    func toggleAcceleration()
    func save(text: String)
    func removeData()
}

final class ActivityReaderInteractor: ActivityReaderBusinessLogic {
    
    public var presenter: ActivityReaderPresentationLogic?
    private var accelerometerService = ActivityReaderService()
    private var storageService = StorageService()
    
    private var currentState: TimerState = .stop
    var data: [MotionData] = []
    var accelerometerData: [Vector] = []
    var gyroscopeData: [Vector] = []
    
    func toggleAcceleration() {
        self.currentState = self.currentState.opposite()
        self.presenter?.displayButtonImage(name: self.currentState.imageName())
        
        switch self.currentState {
        case .start:
            self.accelerometerService.startAccelerometer(updatingData: { [weak self] data in
                self?.presenter?.display(acceleration: data.acc)
                self?.data.append(data)
            })
            
        case .stop:
            self.presenter?.showAlert()
            self.accelerometerService.stopAccelerometer()
        }
    }
    
    func save(text: String) {
        self.storageService.save(self.data, name: text)
        
        let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let items = [url.appendingPathComponent("\(text).csv")]
        self.presenter?.showActivityViewController(with: items)
        
        self.removeData()
    }
    
    func removeData() {
        self.accelerometerData = []
        self.gyroscopeData = []
    }
}
