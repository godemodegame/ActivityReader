import CoreMotion

class ActivityReaderService {
    let hertz: Double = 50
    let manager = CMMotionManager()
    var timer: Timer?
    
    var isActive = false
    
    func startAccelerometer(updatingData: @escaping (ActivityReader.Acceleration) -> Void){
        print("starting accelerometer")
        
        self.isActive = true
        self.manager.startAccelerometerUpdates()
        
        self.timer = Timer.scheduledTimer(withTimeInterval: 1/self.hertz, repeats: true, block: { _ in
            if let measurements = self.manager.accelerometerData {
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
        self.isActive = false
        self.manager.stopAccelerometerUpdates()
        self.timer?.invalidate()
    }
}
