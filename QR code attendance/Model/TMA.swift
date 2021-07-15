//
//  TMA.swift
//  Time Manage Authority
//  QR code attendance
//
//  Created by Ivan Villanueva on 14/07/21.
//

import Foundation

class TMA: ObservableObject {
    
    @Published var inRange:Bool = false
    
    private let date: Date = Date()
    private let calendar: Calendar = Calendar.current
    private var hour:Int = 0
    private var minutes: Int = 0
    
    let timeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "HH:mm"
        
        return formatter
    }()
    
    func manageTime(classDays:[Int], classTime:Dictionary<String,String>){
        let currentDay = getCurrentDay()
        let currentTime:Float = Float(dateTimeChangeFormat(str: getCurrentTime(), inDateFormat: "HH:mm", outDateFormat: "HH.mm"))!
        
        var startTime:Float = 0
        var endTime:Float = 0
        
        for (key, value) in classTime {
            if key == "start" {
                startTime = Float(dateTimeChangeFormat(str: value, inDateFormat: "HH:mm", outDateFormat: "HH.mm"))!
            }
            else {
                endTime = Float(dateTimeChangeFormat(str: value, inDateFormat: "HH:mm", outDateFormat: "HH.mm"))!
            }
        }
        for day in classDays {
            if currentDay == day && (startTime...endTime).contains(currentTime) {
                inRange = true
            }
        }
    } // end manageTime()
    
    func getCurrentDay() -> Int {
        return calendar.component(.weekday, from: date)
    }
    
    func assignDay(_ day:Int) -> String {
        var weekday: String
        
        switch day {
        case 2:
            weekday = "Lunes"
        case 3:
            weekday = "Martes"
        case 4:
            weekday = "Miércoles"
        case 5:
            weekday = "Jueves"
        case 6:
            weekday = "Viernes"
        case 7:
            weekday = "Sábado"
        default:
            weekday = "Domingo"
        }
        
        return weekday
    }
    
    // Gets current time
    private func getCurrentTime() -> String {
        let hour = calendar.component(.hour, from: date)
        let minutes = calendar.component(.minute, from: date)
        
        return "\(hour):\(minutes)"
    }
    
    private func dateTimeChangeFormat(str stringWithDate: String, inDateFormat: String, outDateFormat: String) -> String {
        let inFormatter = DateFormatter()
        inFormatter.locale = Locale(identifier: "en_US_POSIX")
        inFormatter.dateFormat = inDateFormat

        let outFormatter = DateFormatter()
        outFormatter.locale = Locale(identifier: "en_US_POSIX")
        outFormatter.dateFormat = outDateFormat

        let inStr = stringWithDate
        let date = inFormatter.date(from: inStr)!
        
        return outFormatter.string(from: date)
    }
}
