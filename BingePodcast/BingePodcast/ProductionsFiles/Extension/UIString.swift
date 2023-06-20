import Foundation
import UIKit

extension String {

    func secondsToHoursMinutesSecondsToString(_ seconds: Int) -> String {
        let time = [seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60]
        var val = String()
        
        // hours
        if time[0] != 0 && time[0] < 10 {
            val.append("0\(time[0]):")
        }
        if time[0] != 0 && time[0] >= 10 {
            val.append("\(time[0]):")
        }
        
        // minutes
        if time[1] != 0 && time[1] < 10 {
            val.append("0\(time[1]):")
        }
        if time[1] != 0 && time[1] >= 10 {
            val.append("\(time[1]):")
        }
        if time[1] == 0 {
            val.append("00:")
        }
        
        if time[2] >= 10 {
            val.append("\(time[2])")
        } else {
            val.append("0\(time[2])")
        }
        
        return val
    }
    
    enum fonts {
        case proximaNova_Regular
        case proximaNova_Thin
        case proximaNova_Semibold
        case proximaNova_Bold
        case proximaNova_Extrabld
        case proximaNova_Black
        case proximaNova_Alt_Thin
        case proximaNova_Alt_Light
        case proximaNova_Alt_Bold

        func fontName() -> String {
            switch self {
            case .proximaNova_Regular:
                return "ProximaNova-Regular"
            case .proximaNova_Thin:
                return "ProximaNovaT-Thin"
            case .proximaNova_Semibold:
                return "ProximaNova-Semibold"
            case .proximaNova_Bold:
                return "ProximaNova-Bold"
            case .proximaNova_Extrabld:
                return "ProximaNova-Extrabld"
            case .proximaNova_Black:
                return "ProximaNova-Black"
            case .proximaNova_Alt_Thin:
                return "ProximaNovaA-Thin"
            case .proximaNova_Alt_Light:
                return "ProximaNovaA-Light"
            case .proximaNova_Alt_Bold:
                return "ProximaNovaA-Bold"
            }
        }
    }
}
