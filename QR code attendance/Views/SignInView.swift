//
//  SignInView.swift
//  QR code attendance
//
//  Created by Ivan Villanueva on 08/07/21.
//

import SwiftUI
import FirebaseAuth

// VIEW MODEL
class SignInViewModel: ObservableObject {
    let auth = Auth.auth()
    @Published var signedIn:Bool = false
    
    var isSignedIn: Bool {
        return auth.currentUser != nil
    }
    
    func singIn(email:String, password:String) {
        auth.signIn(withEmail: email, password: password) { [weak self] (result, error) in
            guard result != nil, error == nil else {
                return
            }
            // Success
            DispatchQueue.main.async {
                self?.signedIn = true
            }
        }
    }
    
    func signOut() {
        do {
            try auth.signOut()
        } catch let signOutError as NSError {
            print("Error al cerrar la sesión: \(signOutError)")
        }
    }
}


// USER INTERFACE
struct ContentView: View {
    @EnvironmentObject var signInVM: SignInViewModel
    
    var body: some View {
        NavigationView {
            if signInVM.signedIn {
                CourseListView()
                    .navigationTitle("Cursos")
            } else {
                SignInView()
                    .navigationTitle("Iniciar Sesión")
            }
        }
        .padding()
        .offset(y:-60)
        .onAppear { // Auto sign in.
            signInVM.signedIn = signInVM.isSignedIn
        }
    }
}

struct SignInView: View {
    @State var email:String = ""
    @State var password:String = ""
    @State var checkState:Bool = false
    @EnvironmentObject var signInVM: SignInViewModel
    
    var body: some View {
        VStack {
            TextField("Correo elctrónico", text:$email)
                .disableAutocorrection(true)
                .autocapitalization(.none)
            
            SecureField("Constraseña", text:$password)
                .disableAutocorrection(true)
                .autocapitalization(.none)
            
           /* Button(action: {
                // 1. Save State
                self.checkState = !self.checkState
                if self.checkState {
                    signInVM.signedIn = true
                }
                print("State: \(self.checkState)")
            }, label: {
                HStack(alignment: .center, spacing: 10) {
                    Image(systemName: self.checkState ? "checkmark.square.fill": "square")
                        .renderingMode(.original)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 15, height: 15)
                    Text("Mantener sesión iniciada")
                        .font(Font.system(size: 16))
                        
                    Spacer()
                }
                .foregroundColor(.black)
            }).foregroundColor(Color(.systemPink)) */
        
            Button(action: {
                guard !email.isEmpty, !password.isEmpty else {
                    return
                }
                signInVM.singIn(email: email, password: password)
                
            }, label: {
                Text("Iniciar sesión")
                    .bold()
                    .font(.title2)
                    .frame(width: 180, height: 50)
                    .background(Color(.systemOrange))
                    .foregroundColor(.white)
                    .cornerRadius(10)
            })
        }
        .textFieldStyle(RoundedBorderTextFieldStyle())
        .padding(.horizontal, 1)
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(SignInViewModel())
    }
}
