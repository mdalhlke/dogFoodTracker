//
//  LoginView.swift
//  dogFoodTracker
//
//  Created by Rohan Dahlke on 5/5/21.
//

import SwiftUI
import Firebase
import GoogleSignIn
import AuthenticationServices

let lightgray = Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0)

//let facebook = Color(red: 66.0/255.0, green: 103.0/255.0, blue: 178.0/255.0)

let apple = Color(red: 85.0/255.0, green: 85.0/255.0, blue: 85.0/255.0)

let google = Color(red: 66.0/255.0, green: 133.0/255.0, blue: 244.0/255.0)

struct LoginView: View {
    
    @State var user: String = ""
    @State var password: String = ""
    @State private var showPassword: Bool = false
    @State var msg = ""
    @State var alert = false
    @State var show = false
    @StateObject var loginData = AppleLogin()

    var body: some View {
        ZStack {
            lightgray.edgesIgnoringSafeArea(.vertical)
            VStack {
                Spacer()
                Image("kibble-logo-trans")
                    .resizable()
                    .frame(width: 150.0, height: 95.0)
                    .padding()
                Text("kibble")
                    .font(Font.custom("GoodDogPlain", size: 70.0))
                    .padding(.bottom, 20)
                HStack {
                    GoogleSignView().frame(height:55)
                    SignInWithAppleButton { (request) in
                        loginData.nonce = randomNonceString()
                        request.requestedScopes = [.email, .fullName]
                        request.nonce = sha256(loginData.nonce)
                    } onCompletion: { (result) in
                        switch result {
                        case .success(let user):
                            print("success")
                            guard let credential = user.credential as? ASAuthorizationAppleIDCredential else {
                                print("error with firebase")
                                return
                            }
                            loginData.authenticate(credential: credential)
                        case .failure(let error):
                            print(error.localizedDescription)
                        }
                    }
                    .signInWithAppleButtonStyle(.black)
                    .frame(height: 55)
                    //.clipShape(Capsule())
                }
                Text("OR").padding()
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
                    signInWithEmail(email: user, password: password) { (verified, status) in
                        if (!verified) {
                            msg = status
                            alert.toggle()
                        } else {
                            UserDefaults.standard.set(true, forKey: "status")
                            NotificationCenter.default.post(name: NSNotification.Name("statusChange"), object: nil)
                        }
                    }
                }) {
                    Text("Login")
                        .foregroundColor(.white)
                        .font(.title2)
                        .padding(15)
                        .frame(maxWidth: .infinity)
                        .background(Color.orange)
                        .cornerRadius(50.0)
                }
                Spacer()
                HStack {
                   Text("Don't have an account?")
                    
//                    NavigationLink(
//                        destination: SignUpView(show: self.$show),
//                        label: {
//                            Text("Sign Up")
//                                .foregroundColor(.orange)
//                        })
                    
                    Button(action: {
                        self.show.toggle()
                    }) {
                        Text("Sign Up")
                            .foregroundColor(.orange)
                    }
                }
                .fullScreenCover(isPresented: $show) {
                    SignUpView(show: self.$show)
                }
//                .sheet(isPresented: $show) {
//                    SignUpView(show: self.$show)
//                }
                
            }.padding()
            .alert(isPresented: $alert) {
                Alert(title: Text("Error"),
                      message: Text(msg),
                      dismissButton: .default(Text("Okay"))
                )
            }
        }
    }
}

struct GoogleSignView: UIViewRepresentable {
    func makeUIView(context: UIViewRepresentableContext<GoogleSignView>) -> GIDSignInButton {
        let button = GIDSignInButton()
        button.colorScheme = .dark
        GIDSignIn.sharedInstance()?.presentingViewController = UIApplication.shared.windows.last?.rootViewController
        return button
    }
    
    func updateUIView(_ uiView: GIDSignInButton, context: UIViewRepresentableContext<GoogleSignView>) {
        
    }
}

func signInWithEmail(email: String, password: String, completion: @escaping (Bool, String) -> Void) {
    Auth.auth().signIn(withEmail: email, password: password) { (res, err) in
        if err != nil {
            completion(false, (err?.localizedDescription)!)
            return
        }
        completion(true, (res?.user.email)!)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
