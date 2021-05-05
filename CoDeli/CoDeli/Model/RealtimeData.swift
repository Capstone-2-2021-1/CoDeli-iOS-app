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
    @Published var messages = [Message]()
    // dummy
    @Published var myInfo = User(email: "sspog.lim@gmail.com",
                                 name: "임창성",
                                 nickname: "cslim")

    func fetchData(roomId: Int) {
        var ref: DatabaseReference!
        ref = Database.database().reference()

        // Listen for new comments in the Firebase database
//        ref.observe(.childAdded, with: { (snapshot) -> Void in
//            print(snapshot)
//        })

        // 방의 참가자 목록 가져오기
        ref.child("Chat/\(roomId)/partitions").observe(DataEventType.value, with: { (snapshot) in
            self.participants = []

            let dict = snapshot.value as? [String : AnyObject] ?? [:]
            for (person, info) in dict {

                let infoDict = info as? [String: AnyObject] ?? [:]

//                // 이미 참가한 사람이 메뉴 이름, 가격을 수정할 때는 추가가 아닌 갱신
//                for each in self.participants { // participants를 Dictionary로 만들면 for문 필요x
//                    if person == each.id {
//
//                    }
//                }

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
//                print(snap.value as? [String : AnyObject] ?? [:])
//
//            }
        })

        // 방의 채팅 목록 가져오기
//        DataEventType.value
        ref.child("Chat/\(roomId)/chat").observe(DataEventType.value, with: { (snapshot) in
            self.messages = []

            let dict = snapshot.value as? [String : AnyObject] ?? [:]
            for (person, info) in dict {

                let infoDict = info as? [String: AnyObject] ?? [:]

                // 현재 로그인된 사용자가 보낸 메시지인지 확인
                let sender = infoDict["name"] as? String ?? ""
                var isCurrentUser = false
                if sender == self.myInfo.nickname {
                    isCurrentUser = true
                }
                self.messages.append(
                    Message(id: person,
                                message: infoDict["message"] as? String ?? "",
                                name: sender,
                                time: infoDict["time"] as? String ?? "",
                                isCurrentUser: isCurrentUser)
                )
                print(self.messages)
            }
        })
    }

//    func fetchUserData() {
//
//    }
}

struct Participant: Hashable, Codable, Identifiable {
    var id: String
    var menuName: String
    var menuPrice: UInt
    var status: Bool
}

struct Message: Hashable, Codable, Identifiable {
    var id: String  // Firebase RealtimeDB의 chat에 있는 key 값들
    var message: String
    var name: String
    var time: String
    var isCurrentUser: Bool
}

struct User: Hashable, Codable {
    var email: String
    var name: String
    var nickname: String
}
