//
//  ChatView.swift
//  CoDeli
//
//  Created by Changsung Lim on 4/11/21.
//

import SwiftUI
import Firebase
import SlidingTabView

struct ChatView: View {
    // SlidingTabView
    @State private var selectedTabIndex = 0

    @EnvironmentObject var realtimeData: RealtimeData
    @EnvironmentObject var internalData: InternalData

    var ref: DatabaseReference! = Database.database().reference()

    @State private var message: String = ""

    // 약속 시간 설정
    @State private var showingActionSheet = false

    var body: some View {
        let room: Room = internalData.currentRoom

        // 방장이면 방장뷰 보여주기
        if true || internalData.currentRoom.owner == realtimeData.myInfo.nickname || internalData.currentRoom.id >= 0 {
            NavigationView {
                VStack(alignment: .leading) {
                    SlidingTabView(selection: self.$selectedTabIndex, tabs: ["준비", "채팅"])
                    if selectedTabIndex == 0 {
                        VStack(alignment: .leading, spacing: 10, content: {
                            HStack {
                                VStack(alignment: .leading, spacing: 5, content: {
                                    Text("최소주문금액: \(room.minOrderAmount)")
                                        .fontWeight(.bold)
//                                    Text("배달팁: \(room.deliveryCost) (1인당 \(room.deliveryCost/room.participantsMax)원)")
                                    Text("배달팁: \(room.deliveryCost) (1인당 \(room.deliveryCost)원)")

                                        .fontWeight(.bold)
                                })
                                .font(.system(size: 21, design: .rounded))

                                Spacer()

                                Button(internalData.currentRoom.owner == realtimeData.myInfo.nickname ? "지급\n요청" : "도착\n확인") {
                                    if internalData.currentRoom.owner == realtimeData.myInfo.nickname {
                                        ref.child("Chat/\(room.id)/verification").updateChildValues(
                                            ["trigger": true,
                                             "room_manager_wallet": realtimeData.myInfo.klipAddress]
                                        )
                                    } else {
                                        ref.child("Chat/\(room.id)/partitions/\(realtimeData.myInfo.nickname)").updateChildValues(["verification_status": true])
                                    }
                                }
                                .frame(width: 80, height: 80)
                                .background(
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(Color(hex:0x41c072))
                                        .shadow(color: .gray, radius: 2, x: 0, y: 2))
                                .foregroundColor(.white)
                                .font(.system(size: 25, weight: .bold, design: .rounded))
                            }
                            .padding([.top, .leading, .trailing], 3)

                            VStack(alignment: .leading, spacing: 5, content: {
                                Text("사용 플랫폼: \(room.deliveryApp)")
                                Text("배달장소: \(room.deliveryAddress) \(room.deliveryDetailAddress)")
                                HStack {
                                    Text("약속시간: ")

                                    Spacer()

                                    // 방장: 배달 음식 도착 소요시간 입력
                                    if true || internalData.currentRoom.owner == realtimeData.myInfo.nickname {
                                        Button("시간 설정") {
                                            showingActionSheet = true
                                        }
                                        .frame(width: 80, height: 20)
                                        .background(
                                            RoundedRectangle(cornerRadius: 5)
                                                .fill(Color(hex:0xf6cd53))
                                                .shadow(color: .gray, radius: 2, x: 0, y: 2))
                                        .foregroundColor(.white)
                                        .font(.system(size: 15, weight: .semibold, design: .rounded))
                                        .padding(.trailing, 3)
                                    }
                                }
                            })
                            .font(.subheadline)
                            .padding([.leading], 3)
                            .padding([.bottom], 10)

                            ParticipantsView(isChatView: true)
                                .padding([.leading, .trailing], 3)
                        })
                        .actionSheet(isPresented: $showingActionSheet) {
                            ActionSheet(title: Text("약속시간 설정"), message: Text("배달이 도착하는데 걸리는 시간을 알려주세요!"), buttons: [
                                .default(Text("20분")) { print("20분") },
                                .default(Text("30분")) { print("30분") },
                                .default(Text("40분")) { print("40분") },
                                .default(Text("50분")) { print("50분") },
                                .default(Text("60분")) { print("50분") },
                                .cancel()
                            ])
                        }
                    } else if selectedTabIndex == 1 {
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
                                    let df = DateFormatter()

                                    df.dateFormat = "HHmmss"
                                    let messageId = df.string(from: date)

                                    df.dateFormat = "HH:mm"

                                    ref.child("Chat/\(room.id)/chat/\(messageId)").setValue(
                                        ["message": message,
                                         "name": realtimeData.myInfo.nickname,
                                         "time": df.string(from: date)]
                                    )

                                    hideKeyboard()
                                    // 메시지 창 clear
                                    self.message = ""

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
                    }
                    Spacer()
                }
                .navigationBarTitle(room.restaurant, displayMode: .inline)
                .onAppear() {
                    self.realtimeData.fetchData(roomId: room.id)
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
