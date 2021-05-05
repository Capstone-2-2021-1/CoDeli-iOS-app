//
//  MessageCell.swift
//  CoDeli
//
//  Created by Changsung Lim on 5/5/21.
//

import SwiftUI

struct MessageCell: View {
    var message: Message
    var isCurrentUser: Bool

    var body: some View {
        HStack(alignment: .bottom, spacing: 15) {
            if !isCurrentUser {
                Image("profile")
                    .resizable()
                    .frame(width: 40, height: 40, alignment: .center)
                    .cornerRadius(20)
                VStack(alignment: .leading, spacing: 3, content: {
                    Text(message.name)
                        .font(.caption)
                    HStack {
                        Text(message.message)
                            .padding(10)
                            .foregroundColor(isCurrentUser ? Color.white : Color.black)
                            .background(isCurrentUser ? Color.blue : Color(hex: 0xf0f0f0))
                            .cornerRadius(10)
                        Text(message.time)
                            .font(.caption2)
                    }
                })
            } else {
                Spacer()
                HStack {
                    Text(message.time)
                        .font(.caption2)
                    Text(message.message)
                        .padding(10)
                        .foregroundColor(isCurrentUser ? Color.white : Color.black)
                        .background(isCurrentUser ? Color.blue : Color(hex: 0xf0f0f0))
                        .cornerRadius(10)
                }
            }

        }
    }
}

struct MessageCell_Previews: PreviewProvider {
    static var messages = RealtimeData().messages

    static var previews: some View {
        MessageCell(message: messages[0], isCurrentUser: false)
    }
}
