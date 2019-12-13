import Foundation

protocol ActivityReaderBusinessLogic {
    func makeRequest(request: ActivityReader.Model.Request.RequestType)
}

class ActivityReaderInteractor: ActivityReaderBusinessLogic {
    
    public var presenter: ActivityReaderPresentationLogic?
    private var service: ActivityReaderService?
    
    var data: [ActivityReader.Acceleration] = []
    
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
                    self.data.append(data)
                })
            } else {
                self.presenter?.presentData(response: .showAlert)
                self.presenter?.presentData(response: .changeButton(type: .play))
                self.service?.stopAccelerometer()
            }
        case .save(let text):
            print("save \(text)\n\(self.data)")
            self.data = []
        case .delete:
            self.data = []
        }
    }
    
}
