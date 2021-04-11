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
            ProgressView(value: /*@START_MENU_TOKEN@*/0.5/*@END_MENU_TOKEN@*/)
                .progressViewStyle(DefaultProgressViewStyle())
            Text("\(room.currentValue)")
            Text("\(room.minOrderAmount)원 (배달팁: \(room.deliveryCost)원)")
            HStack {
                Text("\(room.deriveryAddress) \(room.deriveryDetailAddress)")
                Spacer()
                Text("\(room.participantsNum)/\(room.participantsMax)")
            }
        }
    }
}

struct HomeRow_Previews: PreviewProvider {
    static var previews: some View {
        HomeRow(room: rooms[0])
    }
}
