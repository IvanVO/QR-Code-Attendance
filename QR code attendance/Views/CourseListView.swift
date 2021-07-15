//
//  CourseListView.swift
//  QR code attendance
//
//  Created by Ivan Villanueva on 08/07/21.
//
import Foundation
import SwiftUI

struct CourseListView: View {
    @StateObject var course: Course = Course()
    @State var shouldLoad: Bool = true
    
    var body: some View {
        List {
            ForEach(course.courses) { course in
                NavigationLink(
                    destination: CourseDetailView(courseName: course.courseName, courseID: course.courseID, classDays: course.classDays, classTime: course.classTime), label: {
                        CourseCell(course: course)
                    })
            }
        }
        .onAppear {
            if shouldLoad {
                course.retreiveData()
                shouldLoad = false
            }
        }
    }
}

struct CourseCell: View {
    var course: CourseInfo
    
    var body: some View {
        VStack(alignment:.leading, spacing: 1) {
            
            Text(course.courseName)
                .font(.headline)
                .fontWeight(.semibold)
                .lineLimit(2)
                .minimumScaleFactor(0.5)
            
            Text("ID: \(course.courseID)")
                .font(.subheadline)
                .foregroundColor(.secondary)
            Text("Alumnos: \(course.totalStudents)")
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            
        }
    }
}

struct CourseListView_Previews: PreviewProvider {
    static var previews: some View {
        CourseListView()
    }
}
