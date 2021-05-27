//
//  EditProfileView.swift
//  dogFoodTracker
//
//  Created by Rohan Dahlke on 5/6/21.
//

import SwiftUI
import Firebase
import GoogleSignIn

struct EditProfileView: View {
    
    //let grayOrange = Color(red: 204.0/255.0, green: 119.0/255.0, blue: 0.0/255.0)

    //@State var name: String = "Maya"
    @State var name: String = "Enter Your Name Here"
    @State var newName: String = ""
    //@State var email: String = "mdahlke123@gmail.com"
    @State var email: String = "Enter Your Email Here"
    @State var newEmail: String = ""
    @State var showPassword: Bool = false
    @State var password: String = "password"
    @State var newPassword: String = ""
    
    @State private var showingAlertName = false
    @State private var showingAlertEmail = false
    @State private var showingAlertPass = false
    
    func getName() -> String {
        //@State var name: String = "Enter Your Name Here"
        if (Auth.auth().currentUser?.displayName != nil) {
            name = (Auth.auth().currentUser?.displayName)!
            print(name)
        } else if (GIDSignIn.sharedInstance()?.currentUser.profile.name != nil) {
            name = (GIDSignIn.sharedInstance()?.currentUser.profile.name)!
            print(name)
        }
        return name
    }
    
    func updateName() -> String {
        //@State var name: String = "Enter Your Name Here"
        if (Auth.auth().currentUser?.displayName != nil) {
            //Auth.auth().currentUser?.updateEmail(to: newEmail, completion: <#T##((Error?) -> Void)?##((Error?) -> Void)?##(Error?) -> Void#>)
            print(name)
        } else if (GIDSignIn.sharedInstance()?.currentUser.profile.name != nil) {
            name = (GIDSignIn.sharedInstance()?.currentUser.profile.name)!
            print(name)
        }
        return name
    }
    
    func getEmail() -> String {
        //@State var email: String = "Enter Your Email Here"
        if (Auth.auth().currentUser?.email != nil) {
            email = (Auth.auth().currentUser?.email)!
            print(email)
        } else if (GIDSignIn.sharedInstance()?.currentUser.profile.email != nil) {
            email = (GIDSignIn.sharedInstance()?.currentUser.profile.email)!
            print(email)
        }
        return email
    }
    
    func updateEmail() -> String {
        //@State var name: String = "Enter Your Name Here"
        if (Auth.auth().currentUser?.displayName != nil) {
            //Auth.auth().currentUser?.updateEmail(to: newEmail, completion: <#T##((Error?) -> Void)?##((Error?) -> Void)?##(Error?) -> Void#>)
            print(name)
        } else if (GIDSignIn.sharedInstance()?.currentUser.profile.name != nil) {
            //name = (GIDSignIn.sharedInstance()?.currentUser.profile.name)!
            //GIDSignIn.sharedInstance()?.currentUser.profile!
            print(name)
        }
        return name
    }

    
    var body: some View {
        ZStack {
            lightgray.edgesIgnoringSafeArea(.vertical)
            VStack(alignment:.leading) {
                Text("Name: \(getName())")
                    .font(.title2)
                TextField("Name", text: $newName)
                   .padding()
                   .background(Color.white)
                   .cornerRadius(5.0)
                Button(action: {
                    showingAlertName = true
                }) {
                    Text("Change Username")
                        .foregroundColor(newName.isEmpty ? Color.gray : Color.orange)
                }.alert(isPresented: $showingAlertName) {
                    Alert(
                        title: Text("Are you sure you want to update name to '\(newName)'?"),
                        primaryButton: .default(
                            Text("Yes"),
                            action: {
                                name = newName
                                newName = ""
                            }
                        ),
                        secondaryButton: .destructive(
                            Text("Cancel"),
                            action: {
                                newName = ""
                            }
                        ))
                }.disabled(newName.isEmpty).padding(.bottom, 20)

                Text("Email: \(getEmail())")
                    .font(.title2)
                TextField("Email", text: $newEmail)
                    .keyboardType(.emailAddress)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(5.0)
                Button(action: {
                    showingAlertEmail = true
                }) {
                    Text("Change Email")
                        .foregroundColor(newEmail.isEmpty ? Color.gray : Color.orange)
                }.alert(isPresented: $showingAlertEmail) {
                    Alert(
                        title: Text("Are you sure you want to update email to '\(newEmail)'?"),
                        primaryButton: .default(
                            Text("Yes"),
                            action: {
                                email = newEmail
                                newEmail = ""
                            }
                        ),
                        secondaryButton: .destructive(
                            Text("Cancel"),
                            action: {
                                newEmail = ""
                            }
                        ))
                }.disabled(newEmail.isEmpty).padding(.bottom, 20)

                Text("Password: •••••••")
                    .font(.title2)
                HStack {
                    if (showPassword) {
                        TextField("Password", text: $newPassword)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(5.0)
                    } else {
                        SecureField("Password", text: $newPassword)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(5.0)
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
                    .accentColor(.orange)
                }
                Button(action: {
                    showingAlertPass = true
                }) {
                    Text("Change Password")
                        .foregroundColor(newPassword.isEmpty ? Color.gray : Color.orange)
                }.alert(isPresented: $showingAlertPass) {
                    Alert(
                        title: Text("Are you sure you want to update password to '\(newPassword)'?"),
                        primaryButton: .default(
                            Text("Yes"),
                            action: updatePassword
                        ),
                        secondaryButton: .destructive(
                            Text("Cancel"),
                            action: {
                                newPassword = ""
                            }
                        ))
                }.disabled(newPassword.isEmpty).padding(.bottom, 40)
            }
            .padding()
        }.navigationBarTitle("Edit Profile")
    }
    
    func updatePassword() {
        //add textfield alert here for extra confirmation of old pass
        password = newPassword
        newPassword = ""
    }

}



struct EditProfileView_Previews: PreviewProvider {
    static var previews: some View {
        EditProfileView()
    }
}
