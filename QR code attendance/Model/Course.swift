//
//  Courses.swift
//  QR code attendance
//
//  Created by Ivan Villanueva on 08/07/21.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

struct CourseInfo:Identifiable {
    let id = UUID()
    let courseName: String
    let totalStudents: Int
    let courseID: String
    let classDays: [Int]
    let classTime: [String:String]
}


class Course: ObservableObject {
    let user = Auth.auth().currentUser
    let db = Firestore.firestore()
  
    @Published var courses = [CourseInfo]()
    
    func retreiveData() {
        // Check if the user is signed in.
        if user != nil {
            // if user is signed in --> retreive all of the user's courses and info.
            db.collection("courses").getDocuments() { [self] (querySnapshot, error) in
                // Check for errors.
                if let error = error {
                    print(error.localizedDescription)
                }
                else { // if there are not errors.
                    for course in querySnapshot!.documents {
                        let courseInfo = course.data()
                        
                        manageData(courseInfo)
                    }
                }
            }
        }
    }// end retreiveData()
    
    private func manageData(_ courseInfo: [String : Any]) {
        var courseName: String = ""
        var students: [Any] = []
        var courseID: String = ""
        var days: [Int] = []
        var time: [String:String] = [:]
        
        for (key, value) in courseInfo {
            if key == "Teacher" && value as! String == user!.uid {
                for (key, value) in courseInfo {
                    switch key {
                    case "Course Name":
                        courseName = value as! String
                    case "Course ID":
                        courseID = value as! String
                    case "Students":
                        students = value as! Array<Any>
                    case "Class days":
                        days = value as! Array<Int>
                    case "Class time":
                        time = value as! Dictionary<String,String>
                    default:
                        let _ = "DEFAULT"
                    }
                }
                self.courses.append(CourseInfo(courseName: courseName, totalStudents: students.count, courseID: courseID, classDays: days, classTime: time))
            }
        }
    } // end manageData()
}
