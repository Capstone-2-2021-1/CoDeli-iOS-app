//
//  GetResultRequest.swift
//  KlipSDK
//
//  Created by conan on 2020/09/08.
//  Copyright © 2020 conan. All rights reserved.
//

import Foundation

public struct GetResultRequest: Codable {
    let requestKey: String
    
    init(requestKey: String) {
        self.requestKey = requestKey
    }
    
    func getParams() -> Parameters {
        return ["request_key": self.requestKey]
    }
}
