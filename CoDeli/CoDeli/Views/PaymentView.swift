//
//  PaymentView.swift
//  CoDeli
//
//  Created by Changsung Lim on 4/11/21.
//

import SwiftUI
import FirebaseFirestore
import KlipSDK

struct PaymentView: View {
    @EnvironmentObject var firestoreData: FirestoreData
    @EnvironmentObject var realtimeData: RealtimeData

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

struct PaymentView_Previews: PreviewProvider {
    static var previews: some View {
        PaymentView()
    }
}
