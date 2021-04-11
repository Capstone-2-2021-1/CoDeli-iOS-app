//
//  PaymentView.swift
//  CoDeli
//
//  Created by Changsung Lim on 4/11/21.
//

import SwiftUI

struct PaymentView: View {
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
            .padding()

        }

    }
}

struct PaymentView_Previews: PreviewProvider {
    static var previews: some View {
        PaymentView()
    }
}
