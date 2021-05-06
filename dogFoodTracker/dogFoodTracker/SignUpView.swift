//
//  SignUpView.swift
//  dogFoodTracker
//
//  Created by Rohan Dahlke on 5/6/21.
//

import SwiftUI

struct SignUpView: View {
    
    @State var name: String = ""
    @State var email: String = ""
    @State var password: String = ""
    @State private var showPassword: Bool = false
    
    var body: some View {
        NavigationView{
            ZStack {
                lightgray.edgesIgnoringSafeArea(.vertical)
                VStack {
                    TextField("Name", text: $name)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(5.0)
                        .padding(.bottom, 20)
                    TextField("Email", text: $email)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(5.0)
                        .padding(.bottom, 20)
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
                        print("button pressed")
                    }) {
                        Text("Sign Up")
                            .foregroundColor(.white)
                            .font(.title2)
                            .padding(15)
                            .frame(maxWidth: .infinity)
                            .background(Color.orange)
                            .cornerRadius(50.0)
                    }
                }.padding()
            }.navigationBarTitle("Sign Up")
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
