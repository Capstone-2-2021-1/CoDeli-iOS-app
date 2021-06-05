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

    @Published var appointmentTime: String = ""
    @Published var klayValue: UInt = 0
    
    //dummy
    @Published var uid: String = "nk7GoNfecmhPnLpKfS6t8YkwT433"

    //dummy - for debug
    @Published var myInfo = User(email: "sspog.lim@gmail.com",
                                 name: "임창성",
                                 nickname: "cslim",
                                 klipAddress: "")
    @Published var serverWalletAddress: String = ""

    var ref: DatabaseReference! = Database.database().reference()

    func fetchData(roomId: Int) {

        // Listen for new comments in the Firebase database
//        ref.observe(.childAdded, with: { (snapshot) -> Void in
//            print(snapshot)
//        })

        // 방의 참가자 목록 가져오기
        ref.child("Chat/\(roomId)/partitions").observe(DataEventType.value, with: { (snapshot) in
            self.participants = []

            let dict = snapshot.value as? [String : AnyObject] ?? [:]
            for (_, info) in dict {
                let infoDict = info as? [String: AnyObject] ?? [:]
                self.participants.append(
                    Participant(id: infoDict["id"] as? String ?? "",
                                menuName: infoDict["menu_name"] as? String ?? "",
                                menuPrice: infoDict["menu_price"] as? UInt ?? 0,
                                status: infoDict["status"] as? Bool ?? false,
                                sendingStatus: infoDict["sendingStatus"] as? String ?? "",
                                expirationTime: infoDict["expiration_time"] as? TimeInterval ?? 0,
                                verificationStatus: infoDict["verification_status"] as? Bool ?? false,
                                verification: infoDict["verification"] as? Bool ?? false,
                                location_verification_status: infoDict["location_verification_status"] as? Bool ?? false)
                )
                print(self.participants)
            }
        })

        // 방의 채팅 목록 가져오기
        ref.child("Chat/\(roomId)/chat").observe(DataEventType.value, with: { (snapshot) in
            self.messages = []

            let dict = snapshot.value as? [String : AnyObject] ?? [:]
            for (messageId, info) in dict {

                let infoDict = info as? [String: AnyObject] ?? [:]

                // 현재 로그인된 사용자가 보낸 메시지인지 확인
                let sender = infoDict["name"] as? String ?? ""
                var isCurrentUser = false
                if sender == self.myInfo.nickname {
                    isCurrentUser = true
                }
                self.messages.append(
                    Message(id: UInt(messageId)!,   // 위험 ㅋㅋ
                                message: infoDict["message"] as? String ?? "",
                                name: sender,
                                time: infoDict["time"] as? String ?? "",
                                isCurrentUser: isCurrentUser)
                )
            }
            self.messages.sort(by: {$0.id < $1.id})
        })

        // 약속 시간 가져오기
        ref.child("Chat/\(roomId)/appointmentTime").observe(DataEventType.value, with: { (snapshot) in
            self.appointmentTime = snapshot.value as? String ?? ""
        })
    }

    func fetchKlayValue() {
        ref.child("klay_value").updateChildValues(["trigger": true])

        // trigger로 서버로 요청보내고 새로 값이 바뀔 때까지 1초 기다림
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.ref.child("klay_value/value").observe(DataEventType.value, with: { (snapshot) in
                self.klayValue = UInt(Float(snapshot.value as? String ?? "")!)
                print(self.klayValue)
            })
        }
    }

//    func fetchUserData() {
//
//    }

//    func fetchServerWalletAddress() {
//        // Read once with an observer
//        ref.child("address").observeSingleEvent(of: .value, with: { (snapshot) in
//            self.serverWalletAddress = snapshot.value as? String ?? ""
//        })
//    }
}

struct Participant: Hashable, Codable, Identifiable {
    var id: String
    var menuName: String
    var menuPrice: UInt
    var status: Bool
    var sendingStatus: String
    var expirationTime: TimeInterval
    var verificationStatus: Bool
    var verification: Bool
    var location_verification_status: Bool
}

struct Message: Hashable, Codable, Identifiable {
    var id: UInt  // Firebase RealtimeDB의 chat에 있는 key 값들
    var message: String
    var name: String
    var time: String
    var isCurrentUser: Bool
}

struct User: Hashable, Codable {
    var email: String
    var name: String
    var nickname: String
    var klipAddress: String
}
