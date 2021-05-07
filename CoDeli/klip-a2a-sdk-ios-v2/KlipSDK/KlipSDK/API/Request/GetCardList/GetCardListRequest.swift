//
//  GetCardListRequest.swift
//  KlipSDK
//
//  Created by conan on 2020/09/08.
//  Copyright © 2020 conan. All rights reserved.
//

import Foundation

public struct GetCardListRequest: Codable {
    let cardAddress: String
    let userAddress: String
    let cursor: String?
    
    init(cardAddress: String, userAddress: String, cursor: String? = nil) {
        self.cardAddress = cardAddress
        self.userAddress = userAddress
        self.cursor = cursor
    }
    
    func getParams() -> Parameters {
        var params = [
            "sca": self.cardAddress,
            "eoa": self.userAddress
        ]
        
        if(self.cursor?.isEmpty == false) {
            params.updateValue(self.cursor!, forKey: "cursor")
        }
        
        return params
    }
}
