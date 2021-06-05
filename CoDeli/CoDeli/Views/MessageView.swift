//
//  MessageView.swift
//  CoDeli
//
//  Created by Changsung Lim on 5/5/21.
//

import SwiftUI
import SwiftUIListSeparator

struct MessageView: View {
    @EnvironmentObject var realtimeData: RealtimeData

    var body: some View {
//        VStack {
//            ForEach(realtimeData.messages, id: \.self) { message in
//                HStack(alignment: .bottom, spacing: 15) {
//                    if !message.isCurrentUser {
//                        Image("profile")
//                            .resizable()
//                            .frame(width: 40, height: 40, alignment: .center)
//                            .cornerRadius(20)
//                        VStack(alignment: .leading, spacing: 3, content: {
//                            Text(message.name)
//                                .font(.caption)
//                            HStack {
//                                Text(message.message)
//                                    .padding(10)
//                                    .foregroundColor(message.isCurrentUser ? Color.white : Color.black)
//                                    .background(message.isCurrentUser ? Color.blue : Color(hex: 0xf0f0f0))
//                                    .cornerRadius(10)
//                                Text(message.time)
//                                    .font(.caption2)
//                            }
//                        })
//                    } else {
//                        Spacer()
//                        HStack {
//                            Text(message.time)
//                                .font(.caption2)
//                            Text(message.message)
//                                .padding(10)
//                                .foregroundColor(message.isCurrentUser ? Color.white : Color.black)
//                                .background(message.isCurrentUser ? Color.blue : Color(hex: 0xf0f0f0))
//                                .cornerRadius(10)
//                        }
//                    }
//                }
//            }
//        }

        if #available(iOS 14, *) {
            ScrollView {
                LazyVStack(spacing: 10) {
                    if realtimeData.messages.count > 0 {
                        ForEach(0...realtimeData.messages.count-1, id: \.self) { i in
                            MessageCell(message: realtimeData.messages[i], isCurrentUser: realtimeData.messages[i].isCurrentUser)
                        }
                    }
                }
            }
        } else {
            List(realtimeData.messages) { message in
                MessageCell(message: message, isCurrentUser: message.isCurrentUser)
            }
            .listSeparatorStyle(.none)
        }
    }
}

struct MessageView_Previews: PreviewProvider {
    static var previews: some View {
        MessageView()
            .environmentObject(RealtimeData())
    }
}
