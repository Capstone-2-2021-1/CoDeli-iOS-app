//
//  RoomDetailView.swift
//  CoDeli
//
//  Created by Changsung Lim on 5/5/21.
//

import SwiftUI
import Firebase

struct RoomDetailView: View {
    @EnvironmentObject var realtimeData: RealtimeData

    var room: Room

    @State private var isReady: Bool = false

    @State private var status: Bool = false
    @State private var menuName: String = ""
    @State private var menuPrice: String = ""

    @State private var message: String = ""

    var body: some View {
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
                Button(isReady ? "취소" : "준비") {
                    isReady = isReady ? false : true // flip
                    status = isReady ? true : false

                    var ref: DatabaseReference!
                    ref = Database.database().reference()
                    ref.child("Chat/\(room.id)/partitions/\(realtimeData.myInfo.nickname)").setValue(
                        ["id": realtimeData.myInfo.nickname,
                         "menu_name": menuName,
                         "menu_price": UInt(menuPrice) ?? 0,    // 위험..
                         "status": status]
                    )

                    hideKeyboard()

                    print("준비 버튼 눌림")
                }
                .frame(width: 80, height: 80)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color(hex:0xf6cd53))
                        .shadow(color: .gray, radius: 2, x: 0, y: 2))
                .foregroundColor(.white)
                .font(.system(.title, design: .rounded))
            }
            .padding(5)

            VStack(alignment: .leading, spacing: 10, content: {
                Text("사용 플랫폼: \(room.deliveryApp)")
                Text("배달장소: \(room.deliveryAddress) \(room.deliveryDetailAddress)")
                Text("약속시간: ")
            })
            .font(.subheadline)
            .padding(5)

            // 내 메뉴 이름, 가격 입력 받음

            VStack {
                HStack {
                    if status {
                        Circle()
                            .frame(width: 5, height: 5)
                            .foregroundColor(.green)
                    } else {
                        Circle()
                            .frame(width: 5, height: 5)
                            .foregroundColor(.red)
                    }
                    Text(realtimeData.myInfo.nickname)
                    TextField(
                        "메뉴 이름",
                        text: $menuName
                    )
                    TextField(
                        "메뉴 가격",
                        text: $menuPrice
                    )
                }
                .padding(.leading)
                .padding(.trailing)
                .textFieldStyle(RoundedBorderTextFieldStyle())

                ParticipantsView()
            }

            MessageView()
//            ScrollView {
//                MessageView()
//            }

            ZStack {
                HStack {
                    TextField(
                        "보낼 메시지를 입력하세요",
                        text: $message
                    )
                    .textFieldStyle(RoundedBorderTextFieldStyle())

                    Spacer()

                    Button(action: {
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
        .navigationBarTitle(room.restaurant)
        .onAppear() {
            self.realtimeData.fetchData(roomId: room.id)
        }
    }
}

struct RoomDetailView_Previews: PreviewProvider {
    static var rooms = FirestoreData().rooms

    static var previews: some View {
        RoomDetailView(room: rooms[0])
            .environmentObject(RealtimeData())
    }
}

#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif
