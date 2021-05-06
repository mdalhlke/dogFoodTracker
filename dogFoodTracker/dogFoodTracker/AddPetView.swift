//
//  AddPetView.swift
//  dogFoodTracker
//
//  Created by Rohan Dahlke on 5/6/21.
//

import SwiftUI

struct AddPetView: View {
    
    @State var petName: String = ""
    @State private var showingAlert = false
    
    init() {
            UIView.appearance(whenContainedInInstancesOf: [UIAlertController.self]).tintColor = .systemOrange
        }
    
    var body: some View {
        NavigationView {
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
                            .background(Color.orange)
                            .cornerRadius(50.0)
                    }.alert(isPresented: $showingAlert) {
                        Alert(title: Text("'\(petName)' was added"), dismissButton: .default(Text("Got it!")))
                    }
                    Spacer()
                }
                .padding()
            }.navigationTitle("Add a Pet")
        }
    }
}

struct AddPetView_Previews: PreviewProvider {
    static var previews: some View {
        AddPetView()
    }
}
