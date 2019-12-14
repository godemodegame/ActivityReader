import Foundation
import CSV

protocol ActivityReaderBusinessLogic {
    func toggleAcceleration()
    func save(text: String)
    func removeData()
}

final class ActivityReaderInteractor: ActivityReaderBusinessLogic {
    
    public var presenter: ActivityReaderPresentationLogic?
    private var service = ActivityReaderService()
    private var storageService = StorageService()
    
    private var currentState: TimerState = .stop
    var data: [Vector] = []
    
    func toggleAcceleration() {
        self.currentState = self.currentState.opposite()
        self.presenter?.displayButtonImage(name: self.currentState.imageName())
        
        switch self.currentState {
        case .start:
            self.service.startAccelerometer(updatingData: { data in
                self.presenter?.display(acceleration: data)
                self.data.append(data)
            })
            
        case .stop:
            self.presenter?.showAlert()
            self.service.stopAccelerometer()
        }
    }
    
    func save(text: String) {
        self.storageService.save(data, name: text)
        
        let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let items = [url.appendingPathComponent("file.csv")]
        self.presenter?.showActivityViewController(with: items)
        
        self.data = []
    }
    
    func removeData() {
        self.data = []
    }
}
