//
//  CourseDetailView.swift
//  QR code attendance
//
//  Created by Ivan Villanueva on 13/07/21.
//
import Foundation
import SwiftUI

struct CourseDetailView: View {
    // THIS STAYS HERE!!!
    @StateObject var tma: TMA = TMA()
    
    var courseName: String
    var courseID: String
    var classDays:[Int] = []
    var classTime:Dictionary<String,String>
    
    // Date and Time
    let date = Date()
    let calendar = Calendar.current
    
    var body: some View {
        VStack {
            Text("")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        VStack {
                            Text(courseName).font(.headline)
                            Text(courseID).font(.subheadline)
                        }
                    }
                }
            if tma.inRange {
                QRCodeView(url: "https://www.google.com")
                Layout(amountOfDays: classDays, tma: tma, classTime: classTime, x1: 100, y1: -130, x2: 60, y2: -130, x3: 55, y3: -265)
            }
            else {
                Layout(amountOfDays: classDays, tma: tma, classTime: classTime, x1: 100, y1: -180, x2: 60, y2: -180, x3: 55, y3: -365)
            }
            
        }.onAppear {
            tma.manageTime(classDays: self.classDays, classTime: self.classTime)
        }
    } // end body
} // end CourseDetailView

struct Layout: View {
    var amountOfDays:[Int]
    var tma:TMA
    var classTime:Dictionary<String, String>
    let x1, y1:CGFloat
    let x2, y2:CGFloat
    let x3, y3:CGFloat
    
    var body: some View{
        Text("Horario:")
            .font(.headline)
            .fontWeight(.semibold)
            .position(x: 35, y: 5)
        if amountOfDays.count == 3 {
            DaysAWeek(amount: amountOfDays, tma: tma)
                .position(x: x1, y: y1)
        } else {
            DaysAWeek(amount: amountOfDays, tma: tma)
                .position(x: x2, y: y2)
        }
        ClassDuration(time: classTime)
            .position(x: x3, y: y3)
    }
}

struct DaysAWeek: View {
    var amount:[Int]
    var tma:TMA
    
    var body: some View {
        HStack {
            ForEach(amount, id:\.self) { day in
                Text(tma.assignDay(day))
                    .font(.headline)
                    .fontWeight(.regular)
            }
        }
        .contentShape(Rectangle())
    }
}

struct ClassDuration: View {
    var time:Dictionary<String, String>
    
    var body: some View {
        HStack {
            ForEach(time.sorted(by: >), id: \.key) { (key, value) in
                if key == "start" {
                    Text("\(value) -")
                        .font(.headline)
                        .fontWeight(.regular)
                }
                else {
                    Text("\(value)")
                        .font(.headline)
                        .fontWeight(.regular)
                }
            }
        }
        .contentShape(Rectangle())
    }
}

struct CourseDetailView_Previews: PreviewProvider {
    static var previews: some View {
        CourseDetailView(courseName: "", courseID: "", classDays:[Int].init(), classTime:Dictionary<String,String>.init())
    }
}
