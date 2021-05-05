//
//  ParticipantsView.swift
//  CoDeli
//
//  Created by Changsung Lim on 5/5/21.
//

import SwiftUI

struct ParticipantsView: View {
    @EnvironmentObject var realtimeData: RealtimeData

    @State private var menuName: String = ""
    @State private var menuPrice: String = ""

    var body: some View {
        VStack {
            HStack {
                Text("나의 닉네임")
                TextField(
                    "메뉴 이름",
                    text: $menuName
                )
                TextField(
                    "메뉴 가격",
                    text: $menuPrice
                )
            }
            List(realtimeData.participants) { participant in
                ParticipantRow(participant: participant)
            }
        }
        .textFieldStyle(RoundedBorderTextFieldStyle())
    }
}

struct ParticipantsView_Previews: PreviewProvider {
    static var previews: some View {
        ParticipantsView()
            .environmentObject(RealtimeData())
    }
}
