//
//  ProfileView.swift
//  dogFoodTracker
//
//  Created by Rohan Dahlke on 5/5/21.
//

import SwiftUI
import Firebase
import GoogleSignIn

struct ProfileView: View {
    
    //@Binding var pets: Pet
    //@Binding var items: Item
    @AppStorage("log_status") var log_status = false  
    @State var name: String = "Maya"
    @State var pets = [
        Pet(name: "Koda"),
        Pet(name: "Teddy")
    ]
    @State var caregivers = [
        CareGiver(name: "Doug"),
        CareGiver(name: "Mily")
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
                                    Text("\(name)")
                                        .font(.title)
                                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                        .padding(.bottom, 5)
                                    NavigationLink(
                                        destination: EditProfileView(),
                                        label: {
                                            Image(systemName: "square.and.pencil")
                                                .foregroundColor(.white)
                                            Text("Edit Information")
                                                .foregroundColor(.white)
                                                .font(.headline)
                                        }
                                    )
                                }
                            }
                        )
                        .padding(.top, 20)
                        .padding(.bottom, 20)
                    RoundedRectangle(cornerRadius: 25)
                        .fill(Color.white)
                        .frame(width: .infinity, height: nil)
                        .overlay(
                            VStack(alignment:.leading) {
                                Text("Pets")
                                    .font(.largeTitle)
                                    .fontWeight(.bold)
                                    .frame(width: 370, height: nil, alignment: .topLeading)
                                    .padding(.vertical)
                                ForEach(pets) { pet in
                                    Text("\(pet.name)")
                                        .font(.title2)
                                }
                                Spacer()
                            }.padding(.leading, 20)
                        ).padding()
                    
                    RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                        .fill(Color.white)
                        .frame(width: .infinity, height: nil)
                        .overlay(
                            VStack(alignment:.leading) {
                                HStack {
                                    Text("Other Caregivers")
                                        .font(.largeTitle)
                                        .fontWeight(.bold)
                                        .frame(width: 300, height: nil, alignment: .topLeading)
                                        .padding(.vertical)
                                    NavigationLink(
                                        destination: AddCareGiverView(careGivers: $caregivers),
                                        label: {
                                            Image(systemName: "plus")
                                        }
                                    )
                                    Spacer()
                                }
                                ForEach(caregivers) { caregiver in
                                    Text("\(caregiver.name)")
                                        .font(.title2)
                                }
                                Spacer()
                            }.padding(.leading, 20)
                        ).padding()
                }
                .navigationTitle("Profile")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {
                            try! Auth.auth().signOut()
                            GIDSignIn.sharedInstance()?.signOut()
                            UserDefaults.standard.set(false, forKey: "status")
                            NotificationCenter.default.post(name: NSNotification.Name("statusChange"), object: nil)
                        }, label: {
                            Text("Logout")
                        })
                    }
                }
            }
        }.accentColor(.orange)
    }
}

struct CareGiver: Identifiable {
    var id = UUID()
    var name: String
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
