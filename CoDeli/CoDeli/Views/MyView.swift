//
//  MyView.swift
//  CoDeli
//
//  Created by Changsung Lim on 4/11/21.
//

import SwiftUI

struct MyView: View {
    var body: some View {
        NavigationView {
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                .navigationBarTitle("설정", displayMode: .large)
                .onAppear() {
                    UINavigationBarAppearance()
                        .setColor(title: .white, background: UIColor(Color(hex: 0x008BBA, alpha: 0.7)))
                }
        }
    }
}

struct MyView_Previews: PreviewProvider {
    static var previews: some View {
        MyView()
    }
}
