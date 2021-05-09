//
//  SignUpView.swift
//  CoDeli
//
//  Created by Changsung Lim on 5/9/21.
//

import SwiftUI

struct SignUpView: View {
    @ObservedObject var info: AppDelegate
    @EnvironmentObject var realtimeData: RealtimeData

    enum SignInState: Int {
        case fail = 0
        case success = 1
        case complete = 2
    }

    @State private var nickname: String = ""

    var body: some View {
        VStack (alignment: .center, spacing: 10, content: {
            Text("회원가입")
                .font(.largeTitle)
            Text("코딜리에 오신걸 환영합니다")
                .font(.subheadline)
                .padding(.bottom, 50)

            VStack (alignment: .leading, spacing: 5, content: {
                Text("이름")
                    .font(.subheadline)
                    .padding(.leading)

                Text(info.name)
                    .padding()
                    .frame(width: 300)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color(hex: 0xEAEAEA))
                            .shadow(color: .gray, radius: 2, x: 0, y: 2))
                    .padding([.leading, .trailing])
            })

            VStack (alignment: .leading, spacing: 5, content: {
                Text("닉네임")
                    .font(.subheadline)
                    .padding(.leading)

                TextField("nickname", text: $nickname)
                    .padding()
                    .frame(width: 300)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color(hex: 0xEAEAEA))
                            .shadow(color: .gray, radius: 2, x: 0, y: 2))
                    .padding([.leading, .trailing])
            })

            VStack (alignment: .leading, spacing: 5, content: {
                Text("이메일")
                    .font(.subheadline)
                    .padding(.leading)

                Text(info.email)
                    .padding()
                    .frame(width: 300)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color(hex: 0xEAEAEA))
                            .shadow(color: .gray, radius: 2, x: 0, y: 2))
                    .padding([.leading, .trailing])
            })
        })
        .padding(.bottom, 50)

        Button(action: {
            print("회원가입 버튼 눌림!")

            // 유저 정보 입력
            realtimeData.myInfo.name = info.name
            realtimeData.myInfo.nickname = nickname
            realtimeData.myInfo.email = info.email

            info.isSignIn = .complete

            // Firebase Realtime DB에 올리기?

        }) {
            Text("회원가입")
                .padding()
        }
        .frame(width: 300, height: 50)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(Color(hex: 0x008BBA, alpha: 0.7))
                .shadow(color: .gray, radius: 2, x: 0, y: 2))
        .foregroundColor(.white)
        .font(.title2)
    }
}

//struct SignUpView_Previews: PreviewProvider {
//    static var previews: some View {
//        SignUpView()
//    }
//}
