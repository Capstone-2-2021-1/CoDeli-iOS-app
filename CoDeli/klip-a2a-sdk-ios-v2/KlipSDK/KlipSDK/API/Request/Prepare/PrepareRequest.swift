//
//  PrepareRequest.swift
//  klip-sdk
//
//  Created by conan on 2020/09/07.
//  Copyright © 2020 conan. All rights reserved.
//

import Foundation

public enum PrepareType: String {
    case auth = "auth"
    case sendKlay = "send_klay"
    case sendFT = "send_token"
    case sendCard = "send_card"
    case contractExecution = "execute_contract"
}


protocol KlipRequestable: Codable {
    var type: String {get}
    var bapp: BAppInfo {get}
}

struct PrepareRequest<T: KlipRequest>: KlipRequestable {
    let type: String
    let bapp: BAppInfo
    let transaction: T?
    
    init(type: PrepareType, bapp: BAppInfo, transaction: T? = nil) {
        self.type = type.rawValue
        self.bapp = bapp
        self.transaction = transaction
    }
    
    func toJson() throws -> Data {
        do {
            return try JSONEncoder().encode(self)
        } catch {
            throw error
        }
    }
}
