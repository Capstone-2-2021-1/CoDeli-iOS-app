//
//  InternalData.swift
//  CoDeli
//
//  Created by Changsung Lim on 5/8/21.
//

import Foundation
import Combine

final class InternalData: ObservableObject {
    @Published var currentRoom: Room = Room(id: -1, restaurant: "", deliveryApp: "", currentValue: 0, minOrderAmount: 0, deliveryCost: 0, deliveryAddress: "", deliveryDetailAddress: "", participantsNum: 0, participantsMax: 0, owner: "")

//    @Published var myOrderInfo = MyOrderInfo(menuName: "", menuPrice: 0)
    @Published var addressList = [Address]()
    @Published var selectedAddress: Address = Address(id: -1, addressName: "", addressNameRoad: "", longitudeX: "", latitudeY: "")
}

struct MyOrderInfo: Hashable, Codable {
    
}

struct Address: Hashable, Codable, Identifiable {
    var id: Int
    let addressName: String
    let addressNameRoad: String
    let longitudeX: String
    let latitudeY: String
}
