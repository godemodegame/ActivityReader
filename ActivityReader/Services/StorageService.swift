import Foundation
import CSV

class StorageService {
    lazy var csv: CSVWriter = {
        let csv = try! CSVWriter(stream: .toMemory())
        try? csv.write(row: ["accX", "accY", "accZ", "gyroX", "gyroY", "gyroZ"])
        return csv
    }()
    
    func save(_ data: [MotionData], name: String) {
        do {
            self.csv.beginNewRow()
            try data.forEach { try self.csv.write(row: ["\($0.acc.x)", "\($0.acc.y)", "\($0.acc.z)", "\($0.gyro.x)", "\($0.gyro.y)", "\($0.gyro.z)", name])}
            
            self.csv.stream.close()
            let csvData = csv.stream.property(forKey: .dataWrittenToMemoryStreamKey) as! Data
            let csvString = String(data: csvData, encoding: .utf8)!
            
            if let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
                let fileURL = path.appendingPathComponent("file.csv")
                try csvString.write(to: fileURL, atomically: true, encoding: .utf8)
            }
        } catch let error {
            print("error to write csv: \(error)")
        }
    }
}
