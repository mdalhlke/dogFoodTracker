//
//  AddCareGiverView.swift
//  dogFoodTracker
//
//  Created by Rohan Dahlke on 5/6/21.
//

import SwiftUI

struct AddCareGiverView: View {
    
    let grayOrange = Color(red: 204.0/255.0, green: 119.0/255.0, blue: 0.0/255.0)
    
    @Binding var careGivers: [CareGiver]
    
    @State var careGiverEmail: String = ""
    @State private var showingAlert = false
    
    var body: some View {
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
                        .background(careGiverEmail.isEmpty ? grayOrange : Color.orange)
                        .cornerRadius(50.0)
                }.alert(isPresented: $showingAlert) {
                    Alert(
                        title: Text("Email was sent to '\(careGiverEmail)'"),
                        dismissButton: .default(
                            Text("Got it!"),
                            action: {
                                careGivers.append(CareGiver(name: careGiverEmail))
                                //sendEmail
                                careGiverEmail = ""
                            }
                        )
                    )
                }.disabled(careGiverEmail.isEmpty)
                Spacer()
            }.padding()
        }.navigationTitle("Add a Care Giver")
    }
}

//struct AddCareGiverView_Previews: PreviewProvider {
//    static var previews: some View {
//        AddCareGiverView()
//    }
//}
