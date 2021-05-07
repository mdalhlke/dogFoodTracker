//
//  SignUpView.swift
//  dogFoodTracker
//
//  Created by Rohan Dahlke on 5/6/21.
//

import SwiftUI
import Firebase
import GoogleSignIn

struct SignUpView: View {
    
    @State var user: String = ""
    //@State var email: String = ""
    @State var password: String = ""
    @State private var showPassword: Bool = false
    @State var alert = false
    @State var msg = ""
    @Binding var show: Bool
    
    var body: some View {
        ZStack {
            lightgray.edgesIgnoringSafeArea(.vertical)
            VStack {
                TextField("Email", text: $user)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(5.0)
                    .padding(.bottom, 20)
                    .keyboardType(.emailAddress)
                HStack {
                    if (showPassword) {
                        TextField("Password", text: $password)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(5.0)
                            .padding(.bottom, 30)
                    } else {
                        SecureField("Password", text: $password)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(5.0)
                            .padding(.bottom, 30)
                    }
                    Button(action: {
                        showPassword.toggle()
                    }, label: {
                        if showPassword {
                            Image(systemName: "eye")
                        } else {
                            Image(systemName: "eye.slash")
                        }
                    })
                    .padding(.bottom, 30)
                    .accentColor(.orange)
                }
                Button(action: {
                    signUpWithEmail(email: user, password: password) { (verified, status) in
                        if (!verified) {
                            self.msg = status
                            alert.toggle()
                        } else {
                            UserDefaults.standard.set(true, forKey: "status")
                            self.show.toggle()
                            NotificationCenter.default.post(name: NSNotification.Name("statusChange"), object: nil)
                        }
                    }
                }) {
                    Text("Sign Up")
                        .foregroundColor(.white)
                        .font(.title2)
                        .padding(15)
                        .frame(maxWidth: .infinity)
                        .background(Color.orange)
                        .cornerRadius(50.0)
                }
            }
            .padding()
            .alert(isPresented: $alert) {
                Alert(title: Text("Error"),
                      message: Text(msg),
                      dismissButton: .default(Text("Okay"))
                )
            }
        }.navigationBarTitle("Sign Up")
    }
}

func signUpWithEmail(email: String, password: String, completion: @escaping (Bool, String) -> Void) {
    Auth.auth().createUser(withEmail: email, password: password) { (res, err) in
        if err != nil {
            completion(false, (err?.localizedDescription)!)
            return
        }
        completion(true, (res?.user.email)!)
    }
}


//struct SignUpView_Previews: PreviewProvider {
//    static var previews: some View {
//        SignUpView()
//    }
//}
