//
//  MessageView.swift
//  CoDeli
//
//  Created by Changsung Lim on 5/5/21.
//

import SwiftUI

struct MessageView: View {
    @EnvironmentObject var realtimeData: RealtimeData

    var body: some View {
        List(realtimeData.messages) { message in
            MessageCell(message: message, isCurrentUser: message.isCurrentUser)
        }
    }
}

struct MessageView_Previews: PreviewProvider {
    static var previews: some View {
        MessageView()
            .environmentObject(RealtimeData())
    }
}
