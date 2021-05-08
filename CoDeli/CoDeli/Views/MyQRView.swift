//
//  MyQRView.swift
//  CoDeli
//
//  Created by Changsung Lim on 5/8/21.
//

import SwiftUI

struct MyQRView: View {
    var body: some View {
        let uid: String = "nk7GoNfecmhPnLpKfS6t8YkwT433"
        let url: String = "http://165.194.44.24:52273/verification/" + uid

        Link("QR code", destination: URL(string: url)!)
    }
}

struct MyQRView_Previews: PreviewProvider {
    static var previews: some View {
        MyQRView()
    }
}
