//
//  Participant.swift
//  CoDeli
//
//  Created by Changsung Lim on 5/5/21.
//

import Foundation
import Combine
import Firebase

final class RealtimeData: ObservableObject {
    @Published var participants = [Participant]()
//    @Published var message = [Message]()

    func fetchData(roomId: Int) {
        var ref: DatabaseReference!
        ref = Database.database().reference()

        // Listen for new comments in the Firebase database
//        ref.observe(.childAdded, with: { (snapshot) -> Void in
//            print(snapshot)
//        })

        // 방의 참가자 목록 가져오기
        ref.child("Chat/\(roomId)/partitions").observe(DataEventType.value, with: { (snapshot) in
            let dict = snapshot.value as? [String : AnyObject] ?? [:]
            for (person, info) in dict {
                let infoDict = info as? [String: AnyObject] ?? [:]
                self.participants.append(
                    Participant(id: infoDict["id"] as? String ?? "",
                                menuName: infoDict["menu_name"] as? String ?? "",
                                menuPrice: infoDict["menu_price"] as? UInt ?? 0,
                                status: infoDict["status"] as? Bool ?? false)
                )
                print(self.participants)
            }

//            for child in snapshot.children {
//                let snap = child as! DataSnapshot
//
//                print(snap.value as? [String : AnyObject] ?? [:])
//                switch snap.key {
//                case "id":
//                    print(snap.value as! String)
//                case "menu_name":
//                    print(snap.value as! String)
//                case "menu_price":
//                    print(snap.value as! UInt)
//                case "status":
//                    print(snap.value as! UInt)
//                default:
//                    print("Realtime DB reading data error!")
//                }

//                participants.append(
//                    Participant(id: s,
//                                menu_name: snap.value[1]!,
//                                menu_price: snap.value[2]!,
//                                status: snap.value[3]!)
//                )
//            }
        })
    }
}

struct Participant: Hashable, Codable, Identifiable {
    var id: String
    var menuName: String
    var menuPrice: UInt
    var status: Bool
}

//struct Message: Hashable, Codable, Identifiable {
//    var message: String
//    var name: String
//    var time: String
//}
