//
//  ParticipantsView.swift
//  CoDeli
//
//  Created by Changsung Lim on 5/5/21.
//

import SwiftUI
import Firebase

struct ParticipantsView: View {
    @EnvironmentObject var realtimeData: RealtimeData

    var ref: DatabaseReference!

    @Binding var status: Bool
    @State private var menuName: String = ""
    @State private var menuPrice: String = ""

    var body: some View {
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

            List(realtimeData.participants) { participant in
                ParticipantRow(participant: participant)
            }
        }
    }
}

struct ParticipantsView_Previews: PreviewProvider {
    static var previews: some View {
        ParticipantsView(status: .constant(false))
            .environmentObject(RealtimeData())
    }
}
