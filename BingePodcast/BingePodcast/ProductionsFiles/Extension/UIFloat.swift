import Foundation
import UIKit

extension Float {
    
    func convertHoursToFloat(totalTime: String) -> Int{
        let delimiter = ":"
        let token = totalTime.components(separatedBy: delimiter)
        
        var newVal = Int()

        if totalTime.count > 5 {
            newVal = (Int(token[0]) ?? 0 ) * 3600
            newVal += (Int(token[1]) ?? 0 ) * 60
            newVal += (Int(token[2]) ?? 0 )
        }
        else if totalTime.count > 3 {
            newVal += (Int(token[0]) ?? 0 ) * 60
            newVal += (Int(token[1]) ?? 0 )
        }
        else {
            newVal += (Int(token[0]) ?? 0 )
        }
        
        
        return newVal
    }
}
