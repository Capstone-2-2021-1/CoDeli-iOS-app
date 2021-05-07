//
//  prepare.swift
//  KlipSDK
//
//  Created by conan on 2020/09/23.
//  Copyright © 2020 Ground1 Corp. All rights reserved.
//

import Foundation

/**
 요청의 결과 정보
 */
public struct PrepareResult: Codable {
    /**
     (Klip 트랜잭션 요청에 대한)  트랜잭션 해시
     */
    public var txHash:String?
    /**
     (Klip 트랜잭션 요청에 대한)  상태 정보
     */
    public var status:String?
    /**
     (Klip 트랜잭션 요청에 대한)  사용자 EOA
     */
    public var klaytnAddress:String?
    
    /**
     JSON 필드명
     */
    enum CodingKeys: String, CodingKey {
        case txHash = "tx_hash"
        case status
        case klaytnAddress = "klaytn_address"
    }
}
