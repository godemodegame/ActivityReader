import CoreMotion

final class ActivityReaderService {
    let hertz: Double = 50
    let manager = CMMotionManager()
    var timer: Timer?
    
    func startAccelerometer(updatingData: @escaping (ActivityReader.Vector) -> Void) {
        self.manager.startAccelerometerUpdates()
        
        self.timer = Timer.scheduledTimer(withTimeInterval: 1 / self.hertz, repeats: true, block: { [weak self] _ in
            if let measurements = self?.manager.accelerometerData {
                let x = measurements.acceleration.x
                let y = measurements.acceleration.y
                let z = measurements.acceleration.z
                
                updatingData(.init(x: x,
                                   y: y,
                                   z: z))
            }
        })
    }
    
    func stopAccelerometer() {
        self.manager.stopAccelerometerUpdates()
        self.timer?.invalidate()
    }
}
