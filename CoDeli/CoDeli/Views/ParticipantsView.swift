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
    
    var body: some View {
        List(realtimeData.participants) { participant in
            ParticipantRow(participant: participant)
        }
    }
}

struct ParticipantsView_Previews: PreviewProvider {
    static var previews: some View {
        ParticipantsView()
            .environmentObject(RealtimeData())
    }
}
