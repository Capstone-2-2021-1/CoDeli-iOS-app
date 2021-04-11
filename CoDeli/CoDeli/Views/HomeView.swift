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
            ZStack {
                List(rooms) { room in
                    HomeRow(room: room)
                }

                VStack {
                    Spacer()    // minLength?

                    HStack {
                        Spacer()
                        Button(action: {
                            print("방 만들기 버튼 눌림")
                        }) {
                            Image("makeRoomButton")
                        }
                        .shadow(color: Color/*@START_MENU_TOKEN@*/.black/*@END_MENU_TOKEN@*/.opacity(0.3), radius: 3, x: 3, y: 3)
                    }
                }
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
