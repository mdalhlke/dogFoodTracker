//
//  AddPetView.swift
//  dogFoodTracker
//
//  Created by Rohan Dahlke on 5/6/21.
//

import SwiftUI

struct AddPetView: View {
    
    let grayOrange = Color(red: 204.0/255.0, green: 119.0/255.0, blue: 0.0/255.0)

    @Binding var pets: [Pet]
    
    @State var petName: String = ""
    @State private var showingAlert = false
    
    
    var body: some View {
        ZStack {
            lightgray.edgesIgnoringSafeArea(.vertical)
            VStack(alignment:.leading) {
                Text("What is your pets name?")
                    .font(.title2)
                    .padding()
                TextField("Name of Pet", text: $petName)
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
                        .background(petName.isEmpty ? grayOrange : Color.orange)
                        .cornerRadius(50.0)
                }.alert(isPresented: $showingAlert) {
                    Alert(
                        title: Text("'\(petName)' was added"),
                        dismissButton: .default(
                            Text("Got it!"),
                            action: {
                                pets.append(Pet(name: petName))
                                petName = ""
                            }
                        )
                    )
                }.disabled(petName.isEmpty)
                Spacer()
            }
            .padding()
        }.navigationTitle("Add a Pet")
    }
}

//struct AddPetView_Previews: PreviewProvider {
//    static var previews: some View {
//        AddPetView()
//    }
//}
