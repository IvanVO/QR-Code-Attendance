//
//  CourseListView.swift
//  QR code attendance
//
//  Created by Ivan Villanueva on 08/07/21.
//

import SwiftUI

struct CourseListView: View {
    @StateObject var course: Course = Course()
    @State var shouldLoad: Bool = true
    
    var body: some View {
        List {
            ForEach(course.courses) { course in
                NavigationLink(
                    destination: CourseDetailView(courseName: course.courseName, courseID: course.courseID), label: {
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
        VStack(alignment:.leading, spacing: 3) {
            
            Text(course.courseName)
                .font(.title2)
                .fontWeight(.semibold)
                .lineLimit(2)
                .minimumScaleFactor(0.5)
            
            Text("Total de alumnos: \(course.totalStudents)")
            
            Text("ID: \(course.courseID)")
        }
    }
}

struct CourseListView_Previews: PreviewProvider {
    static var previews: some View {
        CourseListView()
    }
}
