//
//  CaregiversViewModel.swift
//  dogFoodTracker
//
//  Created by Rohan Dahlke on 5/17/21.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

class CaregiversViewModel: ObservableObject {
    @Published var caregivers = [CareGiver]()
    
    private var db = Firestore.firestore()
    
//    func addCaregiver(caregiver: CareGiver) {
//        do {
//            let _ = try db.collection("caregivers").addDocument(from: caregiver)
//        } catch {
//            print(error)
//        }
//    }
    
    func fetchData() {
        db.collection("caregivers").addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                return
            }
            self.caregivers = documents.compactMap { (queryDocumentSnapshot) -> CareGiver? in
                return try? queryDocumentSnapshot.data(as: CareGiver.self)
//                let data = queryDocumentSnapshot.data()
//                let name = data["name"] as? String ?? ""
//                let email = data["email"] as? String ?? ""
//                return CareGiver(name: name, email: email)
            }
        }
    }

}
