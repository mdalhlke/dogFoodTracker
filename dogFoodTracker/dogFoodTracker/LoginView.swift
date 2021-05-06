//
//  LoginView.swift
//  dogFoodTracker
//
//  Created by Rohan Dahlke on 5/5/21.
//

import SwiftUI

let lightgray = Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0)

let facebook = Color(red: 66.0/255.0, green: 103.0/255.0, blue: 178.0/255.0)

let google = Color(red: 66.0/255.0, green: 133.0/255.0, blue: 244.0/255.0)

struct LoginView: View {
    
    @State var email: String = ""
    @State var password: String = ""
    
    func getfonts() {
        for family in UIFont.familyNames.sorted() {
            let names = UIFont.fontNames(forFamilyName: family)
            print("Family: \(family) Font names: \(names)")
        }
    }

    var body: some View {
        ZStack {
            lightgray.edgesIgnoringSafeArea(.vertical)
            VStack {
                Image(systemName: "circle")
                    .resizable()
                    .frame(width: 100.0, height: 100.0)
                    .padding()
                Text("kibble")
                    .font(Font.custom("GoodDogPlain", size: 70.0))
                    .padding(.bottom, 20)
                HStack{
                    Button(action: {
                        print("button pressed")
                        getfonts()
                    }) {
                        HStack {
                            //Image("iconfinder_09-google_843776")
                            Text("Google")
                                .foregroundColor(.white)
                                .font(.title2)
                                .padding(15)
                                .frame(maxWidth: .infinity)
                                .background(google)
                                .cornerRadius(50.0)
                        }
                    }
                    Button(action: {
                        print("button pressed")
                    }) {
                        //Image("iconfinder_social-facebook_216078")
                        Text("Facebook")
                            .foregroundColor(.white)
                            .font(.title2)
                            .padding(15)
                            .frame(maxWidth: .infinity)
                            .background(facebook)
                            .cornerRadius(50.0)
                    }
                }
                Text("OR").padding()
                TextField("Email", text: $email)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(5.0)
                    .padding(.bottom, 20)
                SecureField("Password", text: $password)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(5.0)
                    .padding(.bottom, 30)
                Button(action: {
                    print("button pressed")
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
                HStack{
                   Text("Don't have an account?")
                    Button(action: {
                        print("button pressed")
                    }) {
                        Text("Sign Up")
                            .foregroundColor(.orange)
                    }
                }
                
            }.padding()
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
