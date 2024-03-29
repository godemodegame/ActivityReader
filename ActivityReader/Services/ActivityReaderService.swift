import CoreMotion

final class ActivityReaderService {
    private let hertz: Double = 50
    private let manager = CMMotionManager()
    private var timer: Timer?
    
    let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss.SSSS"

        return dateFormatter
    }()
    
    func startAccelerometer(updatingData: @escaping (MotionData) -> Void) {
        manager.startAccelerometerUpdates()
        manager.startGyroUpdates()
        
        self.timer = Timer.scheduledTimer(withTimeInterval: 1 / self.hertz, repeats: true, block: { [weak self] _ in
            if let accData = self?.manager.accelerometerData, let gyroData = self?.manager.gyroData {
                let accX = accData.acceleration.x
                let accY = accData.acceleration.y
                let accZ = accData.acceleration.z
                
                let gyroX = gyroData.rotationRate.x
                let gyroY = gyroData.rotationRate.y
                let gyroZ = gyroData.rotationRate.z
                
                updatingData(.init(date: self!.dateFormatter.string(from: Date()),
                                   acc: Vector(x: accX, y: accY, z: accZ),
                                   gyro: Vector(x: gyroX, y: gyroY, z: gyroZ)))
            }
        })
    }
    
    func stopAccelerometer() {
        manager.stopAccelerometerUpdates()
        manager.stopGyroUpdates()
        timer?.invalidate()
    }
}
