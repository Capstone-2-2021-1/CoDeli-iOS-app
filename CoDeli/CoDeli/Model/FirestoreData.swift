//
//  Room.swift
//  CoDeli
//
//  Created by Changsung Lim on 4/11/21.
//

import Foundation
import Combine
import FirebaseFirestore

final class FirestoreData: ObservableObject {
    @Published var rooms = [Room]()

    private var db = Firestore.firestore()

    func fetchData() {
        db.collection("Rooms").addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                return
            }

            self.rooms = documents.map { (queryDocumentSnapshot) -> Room in
                let data = queryDocumentSnapshot.data()
                let id = queryDocumentSnapshot.documentID
                let restaurant = data["restaurant"] as? String ?? ""
                let deliveryApp = data["deliveryApp"] as? String ?? ""
                let currentValue = data["currentValue"] as? UInt ?? 0
                let minOrderAmount = data["minOrderAmount"] as? UInt ?? 0
                let deliveryCost = data["deliveryCost"] as? UInt ?? 0
                let deliveryAddress = data["deliveryAddress"] as? String ?? ""
                let deliveryDetailAddress = data["deliveryDetailAddress"] as? String ?? ""
                let participantsNum = data["participantsNum"] as? UInt ?? 0
                let participantsMax = data["participantsMax"] as? UInt ?? 0
                let owner = data["owner"] as? String ?? ""
                let longitudeX = data["x"] as? String ?? ""
                let latitudeY = data["y"] as? String ?? ""
                return Room(id: Int(id) ?? 0, restaurant: restaurant, deliveryApp: deliveryApp, currentValue: currentValue, minOrderAmount: minOrderAmount, deliveryCost: deliveryCost, deliveryAddress: deliveryAddress, deliveryDetailAddress: deliveryDetailAddress, participantsNum: participantsNum, participantsMax: participantsMax, owner: owner, longitudeX: longitudeX, latitudeY: latitudeY)
            }
        }
    }
}

struct Room: Hashable, Codable, Identifiable {
    var id: Int
    var restaurant: String
    var deliveryApp: String
    var currentValue: UInt
    var minOrderAmount: UInt
    var deliveryCost: UInt
    var deliveryAddress: String
    var deliveryDetailAddress: String
    var participantsNum: UInt
    var participantsMax: UInt
    var owner: String
    var longitudeX: String
    var latitudeY: String
}
