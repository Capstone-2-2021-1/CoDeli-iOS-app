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
    @EnvironmentObject var internalData: InternalData

    var ref: DatabaseReference! = Database.database().reference()

    var room: Room
    var orderCost: UInt
    var deliveryCost: UInt
    var totalCost: UInt
    var stdTime: String

    // KlipSDK 관련
    let klip = KlipSDK.shared
    let bappInfo: BAppInfo = BAppInfo(name : "CoDeli")
    @State private var myRequestKey: String = ""

    @State private var isPaymentComplete: Bool = false

    var body: some View {
        VStack {
            Spacer()

            Text("₩\(orderCost) + ₩\(deliveryCost) (배달팁)")
                .foregroundColor(Color(hex: 0x707070))
            Text("총 ₩\(totalCost)")
                .foregroundColor(Color(hex: 0x193154))
                .font(.title)
            Image("klaytn")
            Text("총 \(Double(totalCost)/Double(realtimeData.klayValue)) KLAY")
                .foregroundColor(Color(hex: 0x193154))
                .font(.system(size: 30, weight: .heavy))
            Text("(1KLAY = ₩\(realtimeData.klayValue), \(stdTime) 기준)")
                .foregroundColor(Color(hex: 0x707070))

            Spacer()

            if !isPaymentComplete {
                Button(action: {
                    print("결제 버튼 눌림!")

                    // server의 지갑 주소 가져오기
    //                realtimeData.fetchServerWalletAddress()
    //                let toWalletAddress = realtimeData.serverWalletAddress

                    // KLAY 전송 트랜잭션 요청문
                    let req: KlayTxRequest = KlayTxRequest(to: "0x697e67f7767558dcc8ffee7999e05807da45002d", amount: "0.001")

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

                    isPaymentComplete = true
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
            } else {
                Button(action: {
                    print("결제 완료 버튼 눌림!")

                    // getResult
                    klip.getResult(requestKey: myRequestKey) { result in
                        switch result {
                        case .success(let response):
                            print("*klip.getResult.success")
                            ref.child("Chat/\(room.id)/partitions/\(realtimeData.myInfo.nickname)").updateChildValues(["tx_hash": response.result?.txHash, "sendingStatus": response.result?.status, "expiration_time": response.expirationTime])
                        case .failure(let error):
                            print("*klip.getResult.failure")
                            print(error)
                        }
                    }
                    // 결제 완료 이후부터
                    internalData.currentRoom = room
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Text("결제 완료")
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
}

struct RoomDetailView: View {
    @State private var isPresented = false

    @EnvironmentObject var firestoreData: FirestoreData
    var db = Firestore.firestore()
    @EnvironmentObject var realtimeData: RealtimeData
    var ref: DatabaseReference! = Database.database().reference()

    var room: Room

    @State private var isReady: Bool = false

    @State private var status: Bool = false
    @State private var menuName: String = ""
    @State private var menuPrice: String = ""

    @State private var message: String = ""

    @State private var deliveryCost: UInt = 0
    @State private var totalCost: UInt = 0
    @State private var totalKlay: Double = 0
    @State private var stdTime: String = ""

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

                        db.collection("Rooms").document(String(room.id)).updateData([
                            "participantsNum": room.participantsNum + 1,
                            "currentValue": room.currentValue + (UInt(menuPrice) ?? 0)
                        ]) { err in
                            if let err = err {
                                print("Error writing document: \(err)")
                            } else {
                                print("Document successfully written!")
                            }
                        }

                        hideKeyboard()
                    }
                    .frame(width: 80, height: 40)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color(hex:0xf6cd53))
                            .shadow(color: .gray, radius: 2, x: 0, y: 2))
                    .foregroundColor(.white)
                    .font(.system(.headline, design: .rounded))
                    .padding(.bottom, 3)

                    Button("결제") {
                        isPresented.toggle()

                        deliveryCost = room.deliveryCost/room.participantsNum
                        totalCost = UInt(menuPrice)! + deliveryCost

                        // 클레이튼 시세 가져오기
                        realtimeData.fetchKlayValue()

                        let date = Date()
                        let df = DateFormatter()
                        df.dateFormat = "yyyy/MM/dd HH:mm"
                        stdTime = df.string(from: date)

                    }
                    .fullScreenCover(isPresented: $isPresented) {
                        PaymentFullScreenModalView(room: room, orderCost: UInt(menuPrice)!, deliveryCost: deliveryCost, totalCost: totalCost, stdTime: stdTime)
                            .environmentObject(realtimeData)
                    }
                    .frame(width: 80, height: 40)
                    .background(RoundedRectangle(cornerRadius: 10)
                                    .fill(Color(hex:0x193154))
                                    .shadow(color: .gray, radius: 2, x: 0, y: 2))
                    .foregroundColor(.white)
                    .font(.system(.headline, design: .rounded))
                }
            }
            .padding([.top, .leading, .trailing], 3)

            VStack(alignment: .leading, spacing: 5, content: {
                Text("사용 플랫폼: \(room.deliveryApp)")
                Text("배달장소: \(room.deliveryAddress) \(room.deliveryDetailAddress)")
                Text("약속시간: ")
            })
            .font(.subheadline)
            .padding([.leading], 3)

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

                ParticipantsView(isChatView: false)
                    .padding(.leading)
                    .padding(.trailing)
            }

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
        })
        .navigationBarTitle(room.restaurant)
        .onAppear() {
            self.realtimeData.fetchData(roomId: room.id)
            for participant in realtimeData.participants {
                if realtimeData.myInfo.nickname == participant.id {
                    isReady = participant.status ? true : false
                    status = participant.status
                    menuName = participant.menuName
                    menuPrice = String(participant.menuPrice)
                }
            }
            print("나타났다!")
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
