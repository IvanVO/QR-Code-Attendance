//
//  CourseDetailView.swift
//  QR code attendance
//
//  Created by Ivan Villanueva on 13/07/21.
//
import SwiftUI


struct CourseDetailView: View {
    var courseName: String
    var courseID: String
    
    var body: some View {
        VStack {
            QRCodeView(url: "https://www.google.com")
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
        }
    }
}

struct CourseDetailView_Previews: PreviewProvider {
    static var previews: some View {
        CourseDetailView(courseName: "", courseID: "")
    }
}
