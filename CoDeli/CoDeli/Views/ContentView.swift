//
//  ContentView.swift
//  CoDeli
//
//  Created by Changsung Lim on 5/5/21.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var info: AppDelegate

    enum SignInState: Int {
        case fail = 0
        case success = 1
    }
    // 나중에 case 하나 더 만들어서 nickname, profileImage 설정하는 화면 만들기

    var body: some View {
        if info.isSignIn == .success {
            return AnyView(MainView())
        } else {
            return AnyView(SignInView())
        }
    }
}
