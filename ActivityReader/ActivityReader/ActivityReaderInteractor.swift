import UIKit

protocol ActivityReaderBusinessLogic {
    func makeRequest(request: ActivityReader.Model.Request.RequestType)
}

class ActivityReaderInteractor: ActivityReaderBusinessLogic {
    
    public var presenter: ActivityReaderPresentationLogic?
    private var service: ActivityReaderService?
    
    func makeRequest(request: ActivityReader.Model.Request.RequestType) {
        if self.service == nil {
            self.service = ActivityReaderService()
        }
        
        switch request {
        case .checkActivityReader:
            if !(self.service?.isActive ?? false) {
                self.presenter?.presentData(response: .changeButton(type: .pause))
                self.service?.startAccelerometer(updatingData: { data in
                    self.presenter?.presentData(response: .displayAcceleration(data: data))
                })
            } else {
                self.presenter?.presentData(response: .showAlert)
                self.presenter?.presentData(response: .changeButton(type: .play))
                self.service?.stopAccelerometer()
            }
        }
    }
    
}
