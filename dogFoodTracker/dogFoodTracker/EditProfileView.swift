//
//  EditProfileView.swift
//  dogFoodTracker
//
//  Created by Rohan Dahlke on 5/6/21.
//

import SwiftUI

struct EditProfileView: View {
    
    @State var name: String = "Maya"
    @State var newName: String = ""
    @State var email: String = "mdahlke123@gmail.com"
    @State var newEmail: String = ""
    @State var showPassword: Bool = false
    @State var password: String = "password"
    @State var newPassword: String = ""
    
    @State private var showingAlertName = false
    @State private var showingAlertEmail = false
    @State private var showingAlertPass = false

    
    var body: some View {
        NavigationView {
            ZStack {
                lightgray.edgesIgnoringSafeArea(.vertical)
                VStack(alignment:.leading) {
                    Text("Name: \(name)")
                        .font(.title2)
                    TextField("Name", text: $newName)
                       .padding()
                       .background(Color.white)
                       .cornerRadius(5.0)
                    Button(action: {
                        showingAlertName = true
                    }) {
                        Text("Change Username")
                            .foregroundColor(.orange)
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
                    }.padding(.bottom, 40)
                    
                    Text("Email: \(email)")
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
                            .foregroundColor(.orange)
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
                    }.padding(.bottom, 40)

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
                            .foregroundColor(.orange)
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
                    }.padding(.bottom, 40)
                }.padding()
            }.navigationBarTitle("Edit Profile")
        }
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