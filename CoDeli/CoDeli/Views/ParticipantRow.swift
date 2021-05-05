//
//  ParticipantRow.swift
//  CoDeli
//
//  Created by Changsung Lim on 5/5/21.
//

import SwiftUI

struct ParticipantRow: View {
    var participant: Participant

    var body: some View {
        HStack {
//            participant.status
            Text(participant.id)
            Spacer()
            Text(participant.menuName)
            Spacer()
            Text(String(participant.menuPrice))
        }
    }
}

struct ParticipantRow_Previews: PreviewProvider {
    static var participants = RealtimeData().participants

    static var previews: some View {
        ParticipantRow(participant: participants[0])
    }
}
