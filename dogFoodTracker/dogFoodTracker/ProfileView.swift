//
//  ProfileView.swift
//  dogFoodTracker
//
//  Created by Rohan Dahlke on 5/5/21.
//

import SwiftUI
import Firebase
import GoogleSignIn
import FirebaseFirestoreSwift

struct ProfileView: View {
    
    //@Binding var pets: Pet
    //@Binding var items: Item
    @AppStorage("log_status") var log_status = false 
    
    @State var showActionSheet = false
    @State var showImagePicker = false
    @State var sourceType: UIImagePickerController.SourceType = .camera
    @State var image: UIImage?
    //@State var name: String = "Enter Your Name Here"
    //@State var name: String = Auth.auth().currentUser?.displayName ?? "Maya"
   // @State var name2: String = GIDSignIn.sharedInstance()?.currentUser.profile.name ?? "Maya"
//    @State var pets = [
//        Pet(name: "Koda"),
//        Pet(name: "Teddy")
//    ]
    private let user = GIDSignIn.sharedInstance().currentUser
    @ObservedObject private var petViewModel = PetsViewModel()
//    @State var caregivers = [
//        CareGiver(name: "Doug", email: "dougdahlke@yahoo.com"),
//        CareGiver(name: "Mily", email: "milydahlke@yahoo.com")
//    ]
    @ObservedObject private var caregiverViewModel = CaregiversViewModel()
    
    @State private var presentAddNewPetScreen = false
    
    func getName() -> String {
        var name: String = "Enter Your Name Here"
        if (Auth.auth().currentUser?.displayName != nil) {
            name = (Auth.auth().currentUser?.displayName)!
            print(name)
        } else if (user?.profile.name != nil) {
            name = (user?.profile.name)!
            print(name)
        }
        return name
    }
    
//    func getProfilePic() {
//        let user: GIDGoogleUser = GIDSignIn.sharedInstance()!.currentUser
//        if user.profile.hasImage {
//            let userDP = user.profile.imageURL(withDimension: 200).absoluteString
//            image = UIImage(systemName: userDP)
//        }
//    }

    
    var body: some View {
        NavigationView {
            ZStack {
                lightgray.edgesIgnoringSafeArea(.vertical)
                VStack {
                    VStack {
                        ZStack(alignment: .bottomTrailing) {
                            NetworkImage(url: user?.profile.imageURL(withDimension: 200))
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 100, height: 100, alignment: .center)
                                .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
//                            if image != nil {
//                                Image(uiImage: image!)
//                                    .resizable()
//                                    .frame(width: 100.0, height: 100.0)
//                                    .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
//                            } else {
//                                Image(systemName: "person.circle.fill")
//                                    .resizable()
//                                    .frame(width: 100.0, height: 100.0)
//                                    .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
//                            }
                            Button(action: {
                                self.showActionSheet = true
                            }) {
                                Image(systemName: "plus")
                                    .foregroundColor(.white)
                                    .frame(width: 25, height: 25)
                                    .background(Color.orange)
                                    .clipShape(Circle())
                                    .overlay(Circle().stroke(Color.white, lineWidth: 2))
                            }.actionSheet(isPresented: $showActionSheet) {
                                ActionSheet(title: Text("Add a picture"), message: nil, buttons: [
                                    .default(Text("Camera"), action: {
                                        self.showImagePicker = true
                                        self.sourceType = .camera
                                    }),
                                    .default(Text("Photo Library"), action: {
                                        self.showImagePicker = true
                                        self.sourceType = .photoLibrary
                                    }),
                                    .cancel()
                                ])
                            }
                            .sheet(isPresented: $showImagePicker) {
                                imagePicker(image: self.$image, showImagePicker: self.$showImagePicker, sourceType: self.sourceType)
                            }
                        }
                        Text(getName())
                            .font(.title)
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                            .padding(.bottom, 5)
                        NavigationLink(
                            destination: EditProfileView(),
                            label: {
                                Image(systemName: "square.and.pencil")
                                    .foregroundColor(.orange)
                                Text("Edit Information")
                                    .foregroundColor(.orange)
                                    .font(.headline)
                            }
                        )
                    }
                    RoundedRectangle(cornerRadius: 25.0)
                        .fill(Color.white)
                        .frame(width: .infinity, height: nil)
                        .overlay(
                            VStack(alignment:.leading) {
                                Text("Pets")
                                    .font(.largeTitle)
                                    .fontWeight(.bold)
                                    .frame(width: 340, height: nil, alignment: .topLeading)
                                    .padding(.vertical, 10.0)
                                ForEach(petViewModel.pets) { pet in
                                    Text("\(pet.name)")
                                        .font(.title2)
                                }
                                Spacer()
                            }.padding(.leading, 20)
                        ).padding()
                    
                    RoundedRectangle(cornerRadius: 25.0)
                        .fill(Color.white)
                        .frame(width: .infinity, height: nil)
                        .overlay(
                            VStack(alignment:.leading) {
                                HStack {
                                    Text("Other Caregivers")
                                        .font(.largeTitle)
                                        .fontWeight(.bold)
                                        .frame(width: 300, height: nil, alignment: .topLeading)
                                        .padding(.vertical, 10.0)
//                                    NavigationLink(
//                                        destination: AddCareGiverView(),
//                                        label: {
//                                            Image(systemName: "plus")
//                                        }
//                                    )
                                    Button(action: {presentAddNewPetScreen.toggle()}, label: {
                                        Image(systemName: "plus")
                                    })
                                    Spacer()
                                }
                                ForEach(caregiverViewModel.caregivers) { caregiver in
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
                .sheet(isPresented: $presentAddNewPetScreen) {
                    AddCareGiverView()
                }
                .onAppear() {
                    self.caregiverViewModel.fetchData()
                    self.petViewModel.fetchData()
                }
            }
        }.accentColor(.orange)
    }
}

struct CareGiver: Identifiable, Codable {
    @DocumentID var id: String? = UUID().uuidString
    var name: String
    var email: String
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case email
    }
}

struct NetworkImage: View {
  let url: URL?

  var body: some View {
    if let url = url,
       let data = try? Data(contentsOf: url),
       let uiImage = UIImage(data: data) {
      Image(uiImage: uiImage)
        .resizable()
        .aspectRatio(contentMode: .fit)
    } else {
      Image(systemName: "person.circle.fill")
        .resizable()
        .aspectRatio(contentMode: .fit)
    }
  }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
