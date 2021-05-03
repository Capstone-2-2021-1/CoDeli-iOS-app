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
    // 나중에 Firebase에서 정보 가져와서 동기화시킬 것임
    @State private var profileName: String = "제인"
    @State private var email: String = "sspog.lim@gmail.com"
    @State private var klipAddress: String = "0xa068880258d070ed13F53BFC5044c1EFA67C4af8"

    @State private var chatNotiEnabled: Bool = true
    @State private var arrivalNotiEnabled: Bool = true

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("프로필")) {
                    HStack(spacing: 15) {
                        ProfileImage()
                        Text("\(profileName)")
                    }
                }
                Section(header: Text("이메일")) {
                    Text("\(email)")
                }
                Section(header: Text("Klip 주소")) {
                    Text("\(klipAddress)")
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
                    Button("편집") {
                        print("편집 버튼 눌림!")
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
