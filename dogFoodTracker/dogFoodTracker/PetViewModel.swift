//
//  PetViewModel.swift
//  dogFoodTracker
//
//  Created by Rohan Dahlke on 5/17/21.
//

import Foundation
import Firebase

class PetViewModel: ObservableObject {
    @Published var pet: Pet = Pet(name: "", breakfast: false, dinner: false, treats: 0)
    private var petViewModel = PetsViewModel()
    
    private var db = Firestore.firestore()
    
    func addPet(pet: Pet) {
        do {
            let _ = try db.collection("pets").addDocument(from: pet)
        } catch {
            print(error)
        }
    }
    
    func save() {
        addPet(pet: pet)
    }
    
    func delete(id: String) {
        db.collection("pets").document(id).delete() { error in
            if let error = error {
                print(error.localizedDescription)
            } else {
                self.petViewModel.fetchData()
                print("Successfully deleted")
            }
        }
    }
    
    func updateBB(id: String) {
        db.collection("pets").document(id).getDocument { (document, error) in
            print("HEE")
            if let document = document, document.exists {
                //let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
               // print("Document data: \(dataDescription)")
                var curr = document.get("breakfast") as! Bool
                print(curr)
                curr.toggle()
                DispatchQueue.main.async {
                    document.reference.updateData(["breakfast": curr])
                }
            } else {
                print("Document does not exist")
            }
        }
    }
    
    func updateDB(id: String) {
        db.collection("pets").document(id).getDocument { (document, error) in
            print("HERE")
            if let document = document, document.exists {
                //let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
               // print("Document data: \(dataDescription)")
                var curr = document.get("dinner") as! Bool
                print(curr)
                curr.toggle()
                DispatchQueue.main.async {
                    document.reference.updateData(["dinner": curr])
                }
            } else {
                print("Document does not exist")
            }
        }
    }
    
    func updateTreatsUp(id: String) {
        db.collection("pets").document(id).getDocument { (document, error) in
            print("HERE")
            if let document = document, document.exists {
                //let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
               // print("Document data: \(dataDescription)")
                var curr = document.get("treats") as! Int
                print(curr)
                curr += 1
                DispatchQueue.main.async {
                    document.reference.updateData(["treats": curr])
                }
            } else {
                print("Document does not exist")
            }
        }
    }
    
    func updateTreatsDown(id: String) {
        db.collection("pets").document(id).getDocument { (document, error) in
            print("HERE")
            if let document = document, document.exists {
                //let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
               // print("Document data: \(dataDescription)")
                var curr = document.get("treats") as! Int
                print(curr)
                if (curr != 0) {
                    curr -= 1
                }
                DispatchQueue.main.async {
                    document.reference.updateData(["treats": curr])
                }
            } else {
                print("Document does not exist")
            }
        }
    }
    
}
