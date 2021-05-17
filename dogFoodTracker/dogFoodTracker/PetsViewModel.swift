//
//  PetsViewModel.swift
//  dogFoodTracker
//
//  Created by Rohan Dahlke on 5/17/21.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

class PetsViewModel: ObservableObject {
    @Published var pets = [Pet]()
    
    private var db = Firestore.firestore()
    
//    func addPet(pet: Pet) {
//        do {
//            let _ = try db.collection("ppets").addDocument(from: pet)
//        } catch {
//            print(error)
//        }
//    }
    
    func fetchData() {
        db.collection("pets").addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                return
            }
            self.pets = documents.compactMap { (queryDocumentSnapshot) -> Pet? in
                return try? queryDocumentSnapshot.data(as: Pet.self)
//                let data = queryDocumentSnapshot.data()
//                let name = data["name"] as? String ?? ""
//                return Pet(name: name)
            }
        }
    }
}
