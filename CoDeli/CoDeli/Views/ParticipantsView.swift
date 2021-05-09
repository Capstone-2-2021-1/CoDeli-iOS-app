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
        VStack {
            ForEach(realtimeData.participants, id: \.self) { participant in
                if !isChatView {    // RoomDetailView 에서는 본인 제외하고 참여자 목록 출력
                    if participant.id != realtimeData.myInfo.nickname {
                        HStack {
                            if !isChatView {
                                if participant.status { // true
                                    Circle()
                                        .frame(width: 5, height: 5)
                                        .foregroundColor(.green)
                                } else {
                                    Circle()
                                        .frame(width: 5, height: 5)
                                        .foregroundColor(.red)
                                }
                            }
                            // ChatView에서는 '준비' 상태를 체크하는게 아니라 '확인' 상태를 체크?
                            Text(participant.id)
                            Spacer()
                            Text(participant.menuName)
                            Spacer()
                            Text(String(participant.menuPrice))
                        }
                    }
                } else {    // ChatView이면 본인까지 출력
                    HStack {
                        if !isChatView {
                            if participant.status { // true
                                Circle()
                                    .frame(width: 5, height: 5)
                                    .foregroundColor(.green)
                            } else {
                                Circle()
                                    .frame(width: 5, height: 5)
                                    .foregroundColor(.red)
                            }
                        }
                        // ChatView에서는 '준비' 상태를 체크하는게 아니라 '확인' 상태를 체크?
                        Text(participant.id)
                        Spacer()
                        Text(participant.menuName)
                        Spacer()
                        Text(String(participant.menuPrice))
                    }
                }
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
