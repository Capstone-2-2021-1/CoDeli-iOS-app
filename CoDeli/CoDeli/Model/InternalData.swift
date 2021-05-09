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
}

struct MyOrderInfo: Hashable, Codable {
    
}
