//
//  ChatView.swift
//  CoDeli
//
//  Created by Changsung Lim on 4/11/21.
//

import SwiftUI
import Firebase

struct ChatView: View {
    @EnvironmentObject var realtimeData: RealtimeData
    var ref: DatabaseReference! = Database.database().reference()

    var body: some View {
        Button("도착\n확인") {
            ref.child("Chat/0/partitions/\(realtimeData.myInfo.nickname)").updateChildValues(["verification_status": true])
        }
        .frame(width: 80, height: 80)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(Color(hex:0x41c072))
                .shadow(color: .gray, radius: 2, x: 0, y: 2))
        .foregroundColor(.white)
        .font(.system(.title2, design: .rounded))
    }
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView()
    }
}
