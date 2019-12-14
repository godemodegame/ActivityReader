import UIKit

enum TimerState {
    case start
    case stop
    
    func opposite() -> Self {
        return self == .start ? .stop : .start
    }
    
    func imageName() -> String {
        switch self {
            
        case .start:
            return "stop.fill"
        case .stop:
            return "play.fill"
        }
    }
}

struct Vector {
    let x: Double
    let y: Double
    let z: Double
}
