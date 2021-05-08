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

    var isChatView: Bool = false

    var body: some View {
        List(realtimeData.participants) { participant in
            if !isChatView {    // RoomDetailView 에서는 본인 제외하고 참여자 목록 출력
                if participant.id != realtimeData.myInfo.nickname {
                    ParticipantRow(participant: participant, isChatView: false)
                }
            } else {    // ChatView이면 본인까지 출력
                ParticipantRow(participant: participant, isChatView: true)
            }

        }
    }
}

struct ParticipantsView_Previews: PreviewProvider {
    static var previews: some View {
        ParticipantsView()
            .environmentObject(RealtimeData())
    }
}
