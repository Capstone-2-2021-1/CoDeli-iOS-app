//
//  SignInView.swift
//  CoDeli
//
//  Created by Changsung Lim on 4/10/21.
//

import SwiftUI

struct SignInView: View {
    @State private var username: String = ""
    @State private var password: String = ""

    @State private var isEditing = false

    var body: some View {
        VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 10, content: {
            Image("logo_title")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 400, height: 300, alignment: .center)

            Group {
                TextField(
                    "username or email",
                    text: $username
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
//            .frame(width: 400, height: 50)
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color(hex: 0xEAEAEA))
                    .shadow(color: .gray, radius: 2, x: 0, y: 2))
            .padding()

            Group {
                Button(action: {
                    print("로그인 버튼 눌림!")
                }) {
                    Text("로그인")
                        .padding()
                }
                .frame(width: 400, height: 50)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color(hex: 0x008BBA, alpha: 0.7))
                        .shadow(color: .gray, radius: 2, x: 0, y: 2))
                .foregroundColor(.white)

                Button(action: {
                    print("회원가입 버튼 눌림!")
                }) {
                    Text("회원가입")
                        .padding()
                }
                .frame(width: 400, height: 50)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color(hex: 0xFFFFFF))
                        .shadow(color: .gray, radius: 2, x: 0, y: 2))
                .foregroundColor(Color(hex: 0x008BBA, alpha: 0.7))
            }
            .font(.title2)
            .padding()

        })
        .padding()
        .autocapitalization(.none)
        .disableAutocorrection(true)
//        .textFieldStyle(RoundedBorderTextFieldStyle())

    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
