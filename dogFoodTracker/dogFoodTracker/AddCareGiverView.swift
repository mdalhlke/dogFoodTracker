//
//  AddCareGiverView.swift
//  dogFoodTracker
//
//  Created by Rohan Dahlke on 5/6/21.
//

import SwiftUI

struct AddCareGiverView: View {
    
    @State var careGiverEmail: String = ""
    @State private var showingAlert = false
    
    var body: some View {
        NavigationView {
            ZStack {
                lightgray.edgesIgnoringSafeArea(.vertical)
                VStack(alignment:.leading) {
                    Text("Who do you want to add?")
                        .font(.title2)
                    Text("Send an email to someone to join your group.")
                        .padding(.vertical)
                    TextField("Email", text: $careGiverEmail)
                        .keyboardType(.emailAddress)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(5.0)
                        .padding(.bottom, 20)
                    Button(action: {
                        showingAlert = true
                    }) {
                        Text("Submit")
                            .foregroundColor(.white)
                            .font(.title2)
                            .padding(15)
                            .frame(maxWidth: .infinity)
                            .background(Color.orange)
                            .cornerRadius(50.0)
                    }.alert(isPresented: $showingAlert) {
                        Alert(
                            title: Text("Email was sent to '\(careGiverEmail)'"),
                            dismissButton: .default(
                                Text("Got it!")
                                //action: sendEmail
                            )
                        )
                    }
                    Spacer()
                }.padding()
            }.navigationTitle("Add a Care Giver")
        }
    }
}

struct AddCareGiverView_Previews: PreviewProvider {
    static var previews: some View {
        AddCareGiverView()
    }
}
