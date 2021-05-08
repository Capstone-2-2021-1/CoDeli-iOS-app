//
//  HomeRow.swift
//  CoDeli
//
//  Created by Changsung Lim on 4/11/21.
//

import SwiftUI

struct HomeRow: View {
    var room: Room

    var body: some View {
        VStack(
            alignment: .leading,
            spacing: 5
        ) {
            Text(room.restaurant)
                .font(.system(size: 20, weight: .bold, design: .rounded))
            ZStack {
                ProgressView(value: Double(room.currentValue) / Double(room.minOrderAmount))
                    .progressViewStyle(DefaultProgressViewStyle())
                    .accentColor(.green)
                    .scaleEffect(x: 1, y: 5, anchor: .center)
                Text("₩\(room.currentValue)")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundColor(.white)
                    .padding(.leading, 5)
            }
            HStack {
                Text("\(room.minOrderAmount)원")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                Text("(배달팁: \(room.deliveryCost)원)")
                    .font(.caption)
            }
            HStack {
                Text("\(room.deliveryAddress) \(room.deliveryDetailAddress)")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                Spacer()
                Image("participant")
                Text("\(room.participantsNum)/\(room.participantsMax)")
            }
        }
    }
}

struct HomeRow_Previews: PreviewProvider {
    static var rooms = FirestoreData().rooms

    static var previews: some View {
        HomeRow(room: rooms[0])
    }
}
