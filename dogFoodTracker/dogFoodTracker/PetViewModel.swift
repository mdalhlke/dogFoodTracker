//
//  PetViewModel.swift
//  dogFoodTracker
//
//  Created by Rohan Dahlke on 5/17/21.
//

import Foundation
import Firebase

class PetViewModel: ObservableObject {
    @Published var pet: Pet = Pet(name: "")
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
}
