//
//  SignUpView.swift
//  CoDeli
//
//  Created by Changsung Lim on 4/11/21.
//

import SwiftUI

struct SignUpView: View {
    @State private var name: String = ""
    @State private var nickname: String = ""
    @State private var email: String = ""
    @State private var password: String = ""

    @State private var isEditing = false

    var body: some View {
        VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 10, content: {
            Text("회원가입")
                .font(.largeTitle)
            Text("코딜리에 오신걸 환영합니다")
                .font(.subheadline)

            Group {
                TextField(
                    "name",
                    text: $name
                ) { isEditing in
                    self.isEditing = isEditing
                } onCommit: {
        //            validate(name: username)
                }

                TextField(
                    "nickname",
                    text: $nickname
                ) { isEditing in
                    self.isEditing = isEditing
                } onCommit: {
        //            validate(name: username)
                }

                TextField(
                    "email",
                    text: $email
                ) { isEditing in
                    self.isEditing = isEditing
                } onCommit: {
        //            validate(name: username)
                }

                TextField(
                    "password",
                    text: $password
                ) { isEditing in
                    self.isEditing = isEditing
                } onCommit: {
        //            validate(name: username)
                }
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color(hex: 0xEAEAEA))
                    .shadow(color: .gray, radius: 2, x: 0, y: 2))
            .padding()

            Button(action: {
                print("회원가입 버튼 눌림!")
            }) {
                Text("회원가입")
                    .padding()
            }
            .frame(width: 400, height: 50)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color(hex: 0x008BBA, alpha: 0.7))
                    .shadow(color: .gray, radius: 2, x: 0, y: 2))
            .foregroundColor(.white)
            .font(.title2)
            .padding()
        })
        .padding()
        .autocapitalization(.none)
        .disableAutocorrection(true)
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
