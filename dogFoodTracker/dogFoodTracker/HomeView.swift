//
//  HomeView.swift
//  dogFoodTracker
//
//  Created by Rohan Dahlke on 5/5/21.
// https://www.youtube.com/watch?v=EWcAPyhf2FE

import SwiftUI
import FirebaseFirestoreSwift

struct HomeView: View {

    let lightgray = Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0)

//    init() {
//        UITableView.appearance().backgroundColor = .clear
//        UITableViewCell.appearance().backgroundColor = .clear
//        UITableView.appearance().separatorStyle = .none
//    }
    
    @State private var showingAlert = false
    
//    @State var pets = [
//        Pet(name: "Koda"),
//        Pet(name: "Teddy")
//    ]
    
    @ObservedObject private var petViewModel = PetsViewModel()
    @StateObject var viewModel = PetViewModel()
    @State private var presentAddNewPetScreen = false
    
//    @State var items = [
//        Item(title: "Breakfast", treat: 0, checked: PetViewModel().pet.breakfast),
//        Item(title: "Dinner", treat: 0, checked: PetViewModel().pet.dinner),
//        Item(title: "Treats", treat: PetViewModel().pet.treats, checked: false)
//    ]
        
    func getDate() -> String {
        let now = Date()
        let formatter = DateFormatter()
        formatter.dateStyle = .full
        //formatter.timeStyle = .full
        let datetime = formatter.string(from: now)
        return datetime
    }
    
    func removeItems(at offsets: IndexSet) {
       // petViewModel.pets.remove(atOffsets: offsets)
        offsets.forEach { index in
            let pet = petViewModel.pets[index]
            viewModel.delete(id: pet.id!)
        }
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                lightgray.edgesIgnoringSafeArea(.vertical)
                ScrollView {
                    VStack(alignment: .leading) {
                        Text(getDate())
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                            .font(.title)
                        if petViewModel.pets.isEmpty {
                            Text("Add a pet by clicking the + button in the top right corner.")
                                .font(.title3)
                                .padding(.top)
                        } else {
                            List {
                                ForEach(petViewModel.pets, id: \.self) { pet in
                                    RoundedRectangle(cornerRadius: 25)
                                        .fill(Color.white)
                                        .frame(width: .infinity, height: 200)
                                        .overlay(
                                            ZStack {
                                                CardView(pet: pet)
                                            }
                                      )
                                }
                                .onDelete(perform: self.removeItems)
                                .listRowBackground(lightgray)
                                .padding(.top, 5)
                                .padding(.bottom, 5)
                            }
                            .frame(height: 600)
                            .listStyle(GroupedListStyle())
                        }
                    }
                    .padding()
                    .navigationBarTitle("Home")
                    .navigationBarItems(leading: EditButton())
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button(action: {presentAddNewPetScreen.toggle()}, label: {
                                Image(systemName: "plus")
                            })
                        }
                    }
                    .sheet(isPresented: $presentAddNewPetScreen) {
                        AddPetView()
                    }
                    .onAppear() {
                        self.petViewModel.fetchData()
                    }
                }
            }
        }.accentColor(.orange)
    }
}

//struct Item: Identifiable {
//    var id = UUID()
//    var title: String
//    var treat: Int
//    var checked: Bool
//}

struct Pet: Identifiable, Hashable, Codable {
    @DocumentID var id: String? = UUID().uuidString
    var name: String
    var breakfast: Bool
    var dinner: Bool
    var treats: Int
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case breakfast
        case dinner
        case treats
    }
}

struct CardView: View {
    @StateObject var viewModel = PetViewModel()
    @State var pet: Pet
    var body: some View {
        VStack(alignment:.leading) {
            Text(pet.name)
                .fontWeight(.bold)
                .font(.title)
                .padding(.vertical, 2.0)
            HStack {
                Text("Breakfast")
                    .fontWeight(.semibold)
                    .font(.title)
                Spacer()
                if pet.breakfast {
                    Image(systemName: "checkmark.circle.fill")
                        .font(.system(size: 25))
                        .foregroundColor(Color.orange)
                } else {
                    Image(systemName: "circle")
                        .font(.system(size: 25))
                        .foregroundColor(Color.gray)
                }
            }.onTapGesture(perform: {
                //pet.breakfast.toggle()
                viewModel.updateBB(id: pet.id!)
                //pet.breakfast.toggle()
            })
            .padding(.vertical, 2.0)
            HStack {
                Text("Dinner")
                    .fontWeight(.semibold)
                    .font(.title)
                Spacer()
                if pet.dinner {
                    Image(systemName: "checkmark.circle.fill")
                        .font(.system(size: 25))
                        .foregroundColor(Color.orange)
                } else {
                    Image(systemName: "circle")
                        .font(.system(size: 25))
                        .foregroundColor(Color.gray)
                }
            }.onTapGesture(perform: {
                //pet.dinner.toggle()
                viewModel.updateDB(id: pet.id!)
            })
            .padding(.vertical, 2.0)
            HStack {
                Text("Treats")
                    .fontWeight(.semibold)
                    .font(.title)
                Spacer()
                Button {
                    print("up")
                } label: {
                    Image(systemName: "arrow.up")
                }.onTapGesture(perform: {
                    //pet.treats += 1
                    viewModel.updateTreatsUp(id: pet.id!)
                })
                Text(String(pet.treats))
                    .fontWeight(.semibold)
                    .font(.title2)
                Button {
                    print("down")
                } label: {
                    Image(systemName: "arrow.down")
                }.onTapGesture(perform: {
                    viewModel.updateTreatsDown(id: pet.id!)
                })
            }
        }
        .padding(.horizontal)
        .contentShape(Rectangle())
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
