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
            for child in snapshot.children {
                print(child)
            }
//            let dict = snapshot.value as? [String : AnyObject] ?? [:]
        })
    }
}

struct Participant: Hashable, Codable, Identifiable {
    var id: String
    var menu_name: String
    var menu_price: UInt
    var status: Bool
}

//struct Message: Hashable, Codable, Identifiable {
//    var message: String
//    var name: String
//    var time: String
//}
