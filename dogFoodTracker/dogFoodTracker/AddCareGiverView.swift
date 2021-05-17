//
//  AddCareGiverView.swift
//  dogFoodTracker
//
//  Created by Rohan Dahlke on 5/6/21.
//

import SwiftUI

struct AddCareGiverView: View {

    @StateObject var viewModel = CaregiverViewModel()
    @State private var showingAlert = false
    
    var body: some View {
        NavigationView {
            ZStack {
                lightgray.edgesIgnoringSafeArea(.vertical)
                VStack(alignment:.leading) {
                    Text("Who do you want to add?")
                        .font(.title2)
                    Text("Notify someone to join your group.")
                        .padding(.vertical)
                    TextField("Email", text: $viewModel.caregiver.email)
                        .keyboardType(.emailAddress)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(5.0)
                        .padding(.bottom, 20)
                    Button(action: {
                        // you also have to get the name from the user and input that too...
                        viewModel.save()
                        showingAlert = true
                    }) {
                        Text("Submit")
                            .foregroundColor(.white)
                            .font(.title2)
                            .padding(15)
                            .frame(maxWidth: .infinity)
                            .background(viewModel.caregiver.email.isEmpty ? Color.gray : Color.orange)
                            .cornerRadius(50.0)
                    }.alert(isPresented: $showingAlert) {
                        Alert(
                            title: Text("Notification was sent to '\(viewModel.caregiver.email)'"),
                            dismissButton: .default(
                                Text("Got it!"),
                                action: {
                                    viewModel.caregiver.email = ""
                                }
                            )
                        )
                    }.disabled(viewModel.caregiver.email.isEmpty)
                    Spacer()
                }.padding()
            }.navigationTitle("Add a Caregiver")
        }
    }
}

//struct AddCareGiverView_Previews: PreviewProvider {
//    static var previews: some View {
//        AddCareGiverView()
//    }
//}
