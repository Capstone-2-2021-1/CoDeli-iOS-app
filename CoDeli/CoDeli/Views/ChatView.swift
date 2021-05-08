//
//  ChatView.swift
//  CoDeli
//
//  Created by Changsung Lim on 4/11/21.
//

import SwiftUI
import Firebase

struct ChatView: View {
    @EnvironmentObject var realtimeData: RealtimeData
    @EnvironmentObject var internalData: InternalData

    var ref: DatabaseReference! = Database.database().reference()

    @State private var message: String = ""

    var body: some View {
        let room: Room = internalData.currentRoom
        if internalData.currentRoom.id >= 0 {
            NavigationView {
                VStack(alignment: .leading, spacing: 10, content: {
                    HStack {
                        VStack(alignment: .leading, spacing: 5, content: {
                            Text("최소주문금액: \(room.minOrderAmount)")
                                .fontWeight(.bold)
                            Text("배달팁: \(room.deliveryCost) (1인당 \(room.deliveryCost/room.participantsMax)원)")
                                .fontWeight(.bold)
                        })
                        .font(.system(size: 21, design: .rounded))

                        Spacer()

                        Button("도착\n확인") {
                            ref.child("Chat/\(room.id)/partitions/\(realtimeData.myInfo.nickname)").updateChildValues(["verification_status": true])
                        }
                        .frame(width: 80, height: 80)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color(hex:0x41c072))
                                .shadow(color: .gray, radius: 2, x: 0, y: 2))
                        .foregroundColor(.white)
                        .font(.system(.title2, design: .rounded))
                    }
                    .padding(5)

                    VStack(alignment: .leading, spacing: 10, content: {
                        Text("사용 플랫폼: \(room.deliveryApp)")
                        Text("배달장소: \(room.deliveryAddress) \(room.deliveryDetailAddress)")
                        Text("약속시간: ")
                    })
                    .font(.subheadline)
                    .padding(5)

                    ParticipantsView(isChatView: true)

                    MessageView()

                    ZStack {
                        HStack {
                            TextField(
                                "보낼 메시지를 입력하세요",
                                text: $message
                            )
                            .textFieldStyle(RoundedBorderTextFieldStyle())

                            Spacer()

                            Button(action: {
                                let date = Date()
                                var calendar = Calendar.current
                                let hour = calendar.component(.hour, from: date)
                                let minute = calendar.component(.minute, from: date)
                                let second = calendar.component(.second, from: date)

                                ref.child("Chat/\(room.id)/chat/\(realtimeData.myInfo.nickname)\(hour)\(minute)\(second)").setValue(
                                    ["message": message,
                                     "name": realtimeData.myInfo.nickname,
                                     "time": "\(hour):\(minute)"]
                                )

                                hideKeyboard()
                                print("메시지 보내기 버튼 눌림!")
                            }) {
                                Image(systemName: "paperplane")
                            }
                            .frame(width: 30, height: 30)
                            .foregroundColor(.white)
                            .background(
                                RoundedRectangle(cornerRadius: 2)
                                    .fill(Color(hex:0x42c273))
                            )
                        }
                        .padding(5)
                    }
                    .background(Color(hex:0x4caece))
                })
                .navigationBarTitle(room.restaurant, displayMode: .inline)
                .onAppear() {
                    UINavigationBarAppearance()
                        .setColor(title: .white, background: UIColor(Color(hex: 0x4caece)))
                }
            }
        } else {
            Text("현재 참여한 방이 없습니다!")
        }
    }
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView()
    }
}
