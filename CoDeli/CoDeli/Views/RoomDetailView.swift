//
//  RoomDetailView.swift
//  CoDeli
//
//  Created by Changsung Lim on 5/5/21.
//

import SwiftUI
import Firebase
import KlipSDK

struct PaymentFullScreenModalView: View {
    @Environment(\.presentationMode) var presentationMode

    @EnvironmentObject var realtimeData: RealtimeData
    var ref: DatabaseReference! = Database.database().reference()

    var room: Room
    @Binding var menuName: String
    @Binding var menuPrice: String
    @Binding var status: Bool

    @State private var orderCost: UInt = 6100
    @State private var deliveryCost: UInt = 500
    @State private var totalCost: UInt = 6600
    @State private var totalKlay: Double = 1.9270072    // 소수점 아래 6자리까지?
    @State private var klayMarketPrice: UInt = 3425
    @State private var stdTime: String = "2021/03/25 16:30"

    var body: some View {
        VStack {
            Spacer()

            Text("₩\(orderCost) + ₩\(deliveryCost) (배달팁)")
                .foregroundColor(Color(hex: 0x707070))
            Text("총 ₩\(totalCost)")
                .foregroundColor(Color(hex: 0x193154))
                .font(.title)
            Image("klaytn")
            Text("총 \(totalKlay) KLAY")
                .foregroundColor(Color(hex: 0x193154))
                .font(.system(size: 30, weight: .heavy))
            Text("(1KLAY = ₩\(klayMarketPrice), \(stdTime) 기준)")
                .foregroundColor(Color(hex: 0x707070))

            Spacer()

            Button(action: {
                print("결제 버튼 눌림!")

                // server의 지갑 주소 가져오기
                realtimeData.fetchServerWalletAddress()
                let toWalletAddress = realtimeData.serverWalletAddress

                let klip = KlipSDK.shared
                let bappInfo: BAppInfo = BAppInfo(name : "CoDeli")
                var myRequestKey: String = ""

                // KLAY 전송 트랜잭션 요청문
                let req: KlayTxRequest = KlayTxRequest(to: "0x697e67f7767558dcc8ffee7999e05807da45002d", amount: "0.01")

                // prepare
                klip.prepare(request: req, bappInfo: bappInfo) { result in
                    switch result {
                    case .success(let response):
                        print("*klip.prepare.success")
                        print(response)
                        myRequestKey = response.requestKey
                    case .failure(let error):
                        print("*klip.prepare.failure")
                        print(error)
                    }
                }

                // 위의 prepare에서 response.requestKey가 myRequestKey에 바로 들어오지 않음.. 일단 임시 방편으로..
                while true {
                    if myRequestKey != "" {
                        break
                    }
                }

                // request - 카카오톡의 Klip앱으로 이동
                klip.request(requestKey: myRequestKey)

                // getResult
                klip.getResult(requestKey: myRequestKey) { result in
                    switch result {
                    case .success(let response):
                        print("*klip.getResult.success")
                        print(response)

                        ref.child("Chat/\(room.id)/partitions/\(realtimeData.myInfo.nickname)").setValue(
                            ["id": realtimeData.myInfo.nickname,
                             "menu_name": menuName,
                             "menu_price": UInt(menuPrice) ?? 0,    // 위험..
                             "status": status,
                             "sendingStatus": response.status,
                             "expiration_time": response.expirationTime]
                        )

                        // 기존의 Firebase 데이터를 다 삭제해버림..
//                        let post = ["sendingStatus": response.status, "expiration_time": response.expirationTime] as [String : Any]
//                        let childUpdates = ["Chat/\(room.id)/partitions/\(realtimeData.myInfo.nickname)": post] as [String : Any]
//                        ref.updateChildValues(childUpdates)

                        presentationMode.wrappedValue.dismiss()
                    case .failure(let error):
                        print("*klip.getResult.failure")
                        print(error)
                    }
                }
            }) {
                Text("결제하기")
                    .padding()
            }
            .frame(width: 400, height: 50)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color(hex: 0x193154))
                    .shadow(color: .gray, radius: 2, x: 0, y: 2))
            .foregroundColor(.white)
            .font(.title2)
        }
    }
}

struct RoomDetailView: View {
    @State private var isPresented = false

    @EnvironmentObject var realtimeData: RealtimeData
    var ref: DatabaseReference! = Database.database().reference()

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

                VStack {
                    Button(isReady ? "취소" : "준비") {
                        isReady = isReady ? false : true // flip
                        status = isReady ? true : false

                        ref.child("Chat/\(room.id)/partitions/\(realtimeData.myInfo.nickname)").setValue(
                            ["id": realtimeData.myInfo.nickname,
                             "menu_name": menuName,
                             "menu_price": UInt(menuPrice) ?? 0,    // 위험..
                             "status": status]
                        )

                        hideKeyboard()
                    }
                    .frame(width: 80, height: 40)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color(hex:0xf6cd53))
                            .shadow(color: .gray, radius: 2, x: 0, y: 2))
                    .foregroundColor(.white)
                    .font(.system(.headline, design: .rounded))
                    .padding(.bottom, 5)

                    Button("결제") {
                        isPresented.toggle()
                    }
                    .fullScreenCover(isPresented: $isPresented) {
                        PaymentFullScreenModalView(room: room, menuName: $menuName, menuPrice: $menuPrice, status: $status)
                    }
                    .frame(width: 80, height: 40)
                    .background(RoundedRectangle(cornerRadius: 10)
                                    .fill(Color(hex:0x193154))
                                    .shadow(color: .gray, radius: 2, x: 0, y: 2))
                    .foregroundColor(.white)
                    .font(.system(.headline, design: .rounded))
                }
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
