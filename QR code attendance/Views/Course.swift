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
        
        for (key, value) in courseInfo {
            if key == "Teacher" && value as! String == user!.uid {
                for (key, value) in courseInfo {
                    if key == "Course Name" {
                        courseName = value as! String
                    }
                    else if key == "Course ID" {
                        courseID = value as! String
                    }
                    else if key == "Students"{
                        students = value as! Array<Any>
                    }
                }
                self.courses.append(CourseInfo(courseName: courseName, totalStudents: students.count, courseID: courseID))
            }
        }
        
    } // end manageData()
}
