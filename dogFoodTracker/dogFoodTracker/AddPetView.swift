//
//  AddPetView.swift
//  dogFoodTracker
//
//  Created by Rohan Dahlke on 5/6/21.
//

import SwiftUI

struct AddPetView: View {
    
    @StateObject var viewModel = PetViewModel()
    @State private var showingAlert = false
    
    var body: some View {
        NavigationView {
            ZStack {
                lightgray.edgesIgnoringSafeArea(.vertical)
                VStack(alignment:.leading) {
                    Text("What is your pet's name?")
                        .font(.title2)
                        .padding()
                    TextField("Name of Pet", text: $viewModel.pet.name)
                        .keyboardType(.default)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(5.0)
                        .padding(.bottom, 20)
                    Button(action: {
                        viewModel.save()
                        showingAlert = true
                    }) {
                        Text("Submit")
                            .foregroundColor(.white)
                            .font(.title2)
                            .padding(15)
                            .frame(maxWidth: .infinity)
                            .background(viewModel.pet.name.isEmpty ? Color.gray : Color.orange)
                            .cornerRadius(50.0)
                    }.alert(isPresented: $showingAlert) {
                        Alert(
                            title: Text("'\(viewModel.pet.name)' was added"),
                            dismissButton: .default(
                                Text("Got it!"),
                                action: {
                                    viewModel.pet.name = ""
                                }
                            )
                        )
                    }.disabled(viewModel.pet.name.isEmpty)
                    Spacer()
                }
                .padding()
            }.navigationTitle("Add a Pet")
        }
    }
}

//struct AddPetView_Previews: PreviewProvider {
//    static var previews: some View {
//        AddPetView(pets: [Pet(name: "Koda"), Pet(name: "Teddy")])
//    }
//}
