//
//  CoDeliApp.swift
//  CoDeli
//
//  Created by Changsung Lim on 4/10/21.
//

import SwiftUI

@main
struct CoDeliApp: App {
    @StateObject private var modelData = ModelData()

    var body: some Scene {
        WindowGroup {
//            SignInView()
            MainView()
                .environmentObject(modelData)
        }
    }
}
