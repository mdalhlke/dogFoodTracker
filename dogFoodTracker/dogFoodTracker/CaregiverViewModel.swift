//
//  CaregiverViewModel.swift
//  dogFoodTracker
//
//  Created by Rohan Dahlke on 5/17/21.
//
import Foundation
import Firebase

class CaregiverViewModel: ObservableObject {
    @Published var caregiver: CareGiver = CareGiver(name: "", email: "")
    
    private var db = Firestore.firestore()
    
    func addCaregiver(caregiver: CareGiver) {
        do {
            let _ = try db.collection("caregivers").addDocument(from: caregiver)
        } catch {
            print(error)
        }
    }

    func save() {
        addCaregiver(caregiver: caregiver)
    }
}
