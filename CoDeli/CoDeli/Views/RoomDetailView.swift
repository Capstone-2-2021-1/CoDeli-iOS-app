//
//  RoomDetailView.swift
//  CoDeli
//
//  Created by Changsung Lim on 5/5/21.
//

import SwiftUI

struct RoomDetailView: View {
    var room: Room

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
                Button("준비") {
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
            .padding(5)

            

            ScrollView {
                ChatView()
            }
        })
        .navigationBarTitle(room.restaurant)
    }
}

struct RoomDetailView_Previews: PreviewProvider {
    static var rooms = ModelData().rooms

    static var previews: some View {
        RoomDetailView(room: rooms[0])
    }
}
