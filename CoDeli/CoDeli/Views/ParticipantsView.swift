//
//  ParticipantsView.swift
//  CoDeli
//
//  Created by Changsung Lim on 5/5/21.
//

import SwiftUI

struct ParticipantsView: View {
//    @ObservedObject var info: RealtimeData

    @State private var menuName: String = ""
    @State private var menuPrice: String = ""

    var body: some View {
        HStack {
//            Text()
            TextField(
                "메뉴 이름",
                text: $menuName
            )
            TextField(
                "메뉴 가격",
                text: $menuPrice
            )
        }
        .textFieldStyle(RoundedBorderTextFieldStyle())
    }
}

struct ParticipantsView_Previews: PreviewProvider {
    static var previews: some View {
        ParticipantsView()
    }
}
