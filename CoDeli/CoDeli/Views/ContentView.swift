//
//  ContentView.swift
//  CoDeli
//
//  Created by Changsung Lim on 5/5/21.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var info: AppDelegate
    @EnvironmentObject var realtimeData: RealtimeData

    enum SignInState: Int {
        case fail = 0
        case success = 1
        case complete = 2
    }
    // 나중에 case 하나 더 만들어서 nickname, profileImage 설정하는 화면 만들기

    var body: some View {
        // for debug - 로그인 생략
//        return AnyView(MainView())

        if info.isSignIn == .success {
            return AnyView(SignUpView(info: info))
        } else if info.isSignIn == .complete {
            return AnyView(MainView())
        } else {
            return AnyView(SignInView())
        }
    }
}
