//
//  SignInView.swift
//  CoDeli
//
//  Created by Changsung Lim on 4/10/21.
//

import SwiftUI
import Firebase
import GoogleSignIn

struct SignInView: View {

    @State private var username: String = ""
    @State private var password: String = ""

    @State private var isEditing = false

    var body: some View {
        VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 50, content: {
            Image("logo_title")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 400, height: 300, alignment: .center)

            // Google Login Button
            Button(action: {
                GIDSignIn.sharedInstance()?.presentingViewController = UIApplication.shared.windows.first?.rootViewController
                GIDSignIn.sharedInstance()?.signIn()
            }) {
                Text(" Sign in with Google ")
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                    .padding(.vertical, 10)
                    .padding(.horizontal, 45)
                    .background(Color.blue)
                    .clipShape(Capsule())
            }
        })
    }
}

struct SignInView_Previews: PreviewProvider {

    static var previews: some View {
        SignInView()
//        VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 10, content: {
//            Image("logo_title")
//                .resizable()
//                .aspectRatio(contentMode: .fill)
//                .frame(width: 400, height: 300, alignment: .center)
//
//            // Google Login Button
//            Button(action: {
//                GIDSignIn.sharedInstance()?.presentingViewController = UIApplication.shared.windows.first?.rootViewController
//                GIDSignIn.sharedInstance()?.signIn()
//            }) {
//                Text(" Sign in with Google ")
//                    .foregroundColor(.white)
//                    .fontWeight(.bold)
//                    .padding(.vertical, 10)
//                    .padding(.horizontal, 45)
//                    .background(Color.blue)
//                    .clipShape(Capsule())
//            }
//        })
    }
}
