//
//  QR_code_attendanceApp.swift
//  QR code attendance
//
//  Created by Ivan Villanueva on 26/06/21.
//

import SwiftUI
import Firebase

@main
struct QR_code_attendanceApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            //SignInView()
            let viewModel = SignInViewModel()
            ContentView()
                .environmentObject(viewModel)
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        
        return true
    }
}
