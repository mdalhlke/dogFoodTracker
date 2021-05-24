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

    @State var items = [
        Item(title: "Breakfast", treat: 0, checked: false),
        Item(title: "Dinner", treat: 0, checked: false),
        Item(title: "Treats", treat: 0, checked: false)
    ]
    
//    @State var pets = [
//        Pet(name: "Koda"),
//        Pet(name: "Teddy")
//    ]
    
    @ObservedObject private var petViewModel = PetsViewModel()
    @StateObject var viewModel = PetViewModel()
    @State private var presentAddNewPetScreen = false
        
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
                                            VStack(alignment:.leading) {
                                                Text("\(pet.name)")
                                                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                                                    .padding(.horizontal)
                                                ForEach(items) { item in
                                                    CardView(item: item)
                                                }
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

struct Item: Identifiable {
    var id = UUID()
    var title: String
    var treat: Int
    var checked: Bool
}

struct Pet: Identifiable, Hashable, Codable {
    @DocumentID var id: String? = UUID().uuidString
    var name: String
    enum CodingKeys: String, CodingKey {
        case id
        case name
    }
}

struct CardView: View {
    @State var item: Item
    var body: some View {
        HStack {
            Text(item.title)
                .fontWeight(.semibold)
                .font(.title2)
            Spacer()
            ZStack {
                if (item.title == "Treats") {
                    HStack {
                        Button(action: {
                            print("counterUp")
                            item.treat += 1
                        }, label: {
                            Image(systemName: "arrow.up")
                        })
                        Text(String(item.treat))
                            .fontWeight(.semibold)
                            .font(.title2)
                        Button(action: {
                            print("counterDown")
                            if (item.treat != 0) {
                                item.treat -= 1
                            }
                        }, label: {
                            Image(systemName: "arrow.down")
                        })
                    }
                } else {
                    Circle()
                        .stroke(item.checked ? Color.orange : Color.gray, lineWidth: 1)
                        .frame(width: 25, height: 25)
                    if item.checked {
                        Image(systemName: "checkmark.circle.fill")
                            .font(.system(size: 25))
                            .foregroundColor(Color.orange)
                    }
                }
            }
        }
        .padding(.horizontal)
        .contentShape(Rectangle())
        .onTapGesture(perform: {
            item.checked.toggle()
        })
    }
}

//struct HomeView_Previews: PreviewProvider {
//    static var previews: some View {
//        HomeView()
//    }
//}
