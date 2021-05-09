//
//  MyView.swift
//  CoDeli
//
//  Created by Changsung Lim on 4/11/21.
//

import SwiftUI

struct ProfileImage: View {
    var body: some View {
            Image("profile")
                .resizable()
                .frame(width: 70, height: 70)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.white, lineWidth: 2))
                .shadow(radius: 5)
    }
}

struct MyView: View {
    @EnvironmentObject var realtimeData: RealtimeData

    @State private var klipAddress: String = ""

    @State private var chatNotiEnabled: Bool = true
    @State private var arrivalNotiEnabled: Bool = true

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("프로필")) {
                    HStack(spacing: 15) {
                        ProfileImage()
                        Text(realtimeData.myInfo.nickname)
                    }
                }
                Section(header: Text("이메일")) {
                    Text(realtimeData.myInfo.email)
                }
                Section(header: Text("Klip 주소")) {
                    TextField("0x...", text: $klipAddress)
//                    Text("\(klipAddress)")
                }
                Section(header: Text("푸시알림 설정")) {
                    Toggle(isOn: $chatNotiEnabled) {
                        Text("채팅 알림")
                    }
                    Toggle(isOn: $arrivalNotiEnabled) {
                        Text("도착 알림")
                    }
                }
            }
            .navigationBarTitle("설정", displayMode: .large)
            .navigationBarItems(
                trailing:
                    Button("저장") {
                        print("저장 버튼 눌림!")
                        realtimeData.myInfo.klipAddress = klipAddress
                    }
                    .foregroundColor(.white)
            )
            .onAppear() {
                UINavigationBarAppearance()
                    .setColor(title: .white, background: UIColor(Color(hex: 0x4caece)))
            }
        }
    }
}

struct MyView_Previews: PreviewProvider {
    static var previews: some View {
        MyView()
    }
}
