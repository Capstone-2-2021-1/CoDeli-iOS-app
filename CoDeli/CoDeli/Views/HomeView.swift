//
//  HomeView.swift
//  CoDeli
//
//  Created by Changsung Lim on 4/11/21.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationView {
            List {
                HomeRow(room: rooms[0])
                HomeRow(room: rooms[1])
            }
            
            .navigationBarTitle("서울 동작구 흑석로 84", displayMode: .inline)
            .navigationBarItems(
                trailing:
                    Button(action: {
                        print("검색 버튼 눌림!")
                    }) {
                        Image(systemName: "magnifyingglass")
                    }
                    .foregroundColor(.white)
            )
            .onAppear() {
                UINavigationBarAppearance()
                    .setColor(title: .white, background: UIColor(Color(hex: 0x008BBA, alpha: 0.7)))
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
