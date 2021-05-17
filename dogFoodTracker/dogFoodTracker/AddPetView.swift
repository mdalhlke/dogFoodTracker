//
//  AddPetView.swift
//  dogFoodTracker
//
//  Created by Rohan Dahlke on 5/6/21.
//

import SwiftUI

struct AddPetView: View {
    
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
                        .background(petName.isEmpty ? Color.gray : Color.orange)
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
//        AddPetView(pets: [Pet(name: "Koda"), Pet(name: "Teddy")])
//    }
//}
