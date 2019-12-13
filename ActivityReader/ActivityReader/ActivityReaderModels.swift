import UIKit

enum ActivityReader {
    
    enum Model {
        struct Request {
            enum RequestType {
                case checkActivityReader
                case save(_ text: String)
                case delete
            }
        }
        struct Response {
            enum ResponseType {
                case displayAcceleration(data: Acceleration)
                case showAlert
                case changeButton(type: ButtonType)
            }
        }
        struct ViewModel {
            enum ViewModelData {
                case showAlert
                case changeButton(image: UIImage?)
                case changeAcceleration(data: Acceleration)
            }
        }
    }
    
    enum ButtonType: String {
        case play = "play.fill"
        case pause = "stop.fill"
    }
    
    struct Acceleration {
        let x: Double
        let y: Double
        let z: Double
    }
}
