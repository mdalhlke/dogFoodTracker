//
//  ProfileView.swift
//  dogFoodTracker
//
//  Created by Rohan Dahlke on 5/5/21.
//

import SwiftUI

struct ProfileView: View {
    
    //@Binding var pets: Pet
    //@Binding var items: Item
    
    @State var pets = [
        Pet(name: "Koda"),
        Pet(name: "Teddy")
    ]
    
    var body: some View {
        NavigationView {
            ZStack {
                lightgray.edgesIgnoringSafeArea(.vertical)
                VStack {
                    RoundedRectangle(cornerRadius: 0)
                        .fill(Color.orange)
                        .frame(width: .infinity, height: 150)
                        .overlay(
                            HStack {
                                Image(systemName: "person.circle.fill")
                                    .resizable()
                                    .frame(width: 100.0, height: 100.0)
                                    .padding()
                                VStack(alignment:.leading) {
                                    Text("Maya Dahlke")
                                        .font(.title)
                                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                    Button(action: {
                                        print("edit clicked")
                                    }, label: {
                                        Image(systemName: "square.and.pencil")
                                            .foregroundColor(.white)
                                        Text("Edit Information")
                                            .foregroundColor(.white)
                                            .font(.headline)
                                    })
                                }
                            }
                        )
                        .padding(.top, 20)
                        .padding(.bottom, 20)
                    RoundedRectangle(cornerRadius: 25)
                        .fill(Color.white)
                        .frame(width: .infinity)
                        .overlay(
                            VStack(alignment:.leading) {
                                Text("Pets")
                                    .font(.largeTitle)
                                    .fontWeight(.bold)
                                    .frame(width: 370, alignment: .topLeading)
                                    .padding(.top, 30)
                                ForEach(pets) { pet in
                                    Text("\u{2022} \(pet.name)")
                                        .font(.title2)
//                                    if (items.title == "Breakfast" || items.checked) {
//                                    Text("\u{2022} Fed in the Morning? Yes")
//                                        .font(.title2)
//                                    } else {
//                                        Text("\u{2022} Fed in the Morning? No")
//                                            .font(.title2)
//                                    }
                                }
                                Spacer()
                            }.padding(.leading, 20)
                        ).padding()
                    
                    Spacer()
                }
                .navigationTitle("Profile")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button("Logout") {
                            print("Help tapped!")
                        }
                    }
                }
            }
        }.accentColor(.orange)
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
