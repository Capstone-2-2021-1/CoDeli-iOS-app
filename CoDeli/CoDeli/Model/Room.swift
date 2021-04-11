//
//  Room.swift
//  CoDeli
//
//  Created by Changsung Lim on 4/11/21.
//

import Foundation

struct Room: Hashable, Codable, Identifiable {
    var id: Int
    var restaurant: String
    var currentValue: UInt
    var minOrderAmount: UInt
    var deliveryCost: UInt
    var deriveryAddress: String
    var deriveryDetailAddress: String
    var participantsNum: UInt
    var participantsMax: UInt
}

var rooms: [Room] =
    [Room(id: 0, restaurant: "맘스터치 중앙대점", currentValue: 9100, minOrderAmount: 12000, deliveryCost: 3000, deriveryAddress: "서울 동작구 흑석로84", deriveryDetailAddress: "중앙대학교 309관", participantsNum: 2, participantsMax: 3),
     Room(id: 1, restaurant: "사현스낵", currentValue: 6000, minOrderAmount: 13000, deliveryCost: 2900, deriveryAddress: "서울 동작구 흑석로84", deriveryDetailAddress: "중앙대학교 310관", participantsNum: 1, participantsMax: 3),
     Room(id: 2, restaurant: "진상천 본점", currentValue: 7000, minOrderAmount: 10000, deliveryCost: 2500, deriveryAddress: "서울 동작구 흑석로24-1", deriveryDetailAddress: "CU 중대후문점", participantsNum: 1, participantsMax: 2),
     Room(id: 3, restaurant: "초밥집입니다", currentValue: 10900, minOrderAmount: 15000, deliveryCost: 100, deriveryAddress: "서울 동작구 흑석로84", deriveryDetailAddress: "중앙대학교 정문", participantsNum: 1, participantsMax: 2),
     Room(id: 4, restaurant: "스쿨푸드 딜리버리 서울대입구역점", currentValue: 7500, minOrderAmount: 12000, deliveryCost: 2500, deriveryAddress: "서울 동작구 양녕로 280-1", deriveryDetailAddress: "CU 상도터널점", participantsNum: 2, participantsMax: 3)]
