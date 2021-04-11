//
//  MainView.swift
//  CoDeli
//
//  Created by Changsung Lim on 4/11/21.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("홈", systemImage: "list.bullet")
                }
            ChatView()
                .tabItem {
                    Label("채팅", systemImage: "message.fill")
                }
            MyView()
                .tabItem {
                    Label("마이", systemImage: "person.fill")
                }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
