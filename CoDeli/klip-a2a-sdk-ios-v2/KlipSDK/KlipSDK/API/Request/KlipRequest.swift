//
//  KlipRequest.swift
//  klip-sdk
//
//  Created by conan on 2020/09/07.
//  Copyright © 2020 conan. All rights reserved.
//

import Foundation

public protocol KlipRequest: Codable {}

/**
 사용자 인증 요청
 */
public struct AuthRequest: KlipRequest {
    /**
     요청에 필요한 정보들 초기화
     */
    public init() {}
}

/**
 KLAY 전송 Tx 요청 정보
 */
public struct KlayTxRequest: KlipRequest {
    /**
     전송받을 주소
     */
    public let to: String
    /**
     전송할 KLAY 금액
     */
    public let amount: String
    /**
     (optional) 송신자 주소
     */
    public let from: String?
    
    /**
     요청에 필요한 정보들 초기화
     */
    public init(to: String, amount: String, from: String? = nil) {
        self.to = to
        self.amount = amount
        self.from = from
    }
}

/**
 Token 전송 Tx 요청 정보
 */
public struct TokenTxRequest: KlipRequest {
    /**
     전송받을 주소
     */
    public let to: String
    /**
     전송할 token 금액
     */
    public let amount: String
    /**
     contract 주소
     */
    public let contract: String
    /**
     (optional) 송신자 주소
     */
    public let from: String?
    
    /**
     요청에 필요한 정보들 초기화
     */
    public init(to: String, amount: String, contract: String, from: String? = nil) {
        self.to = to
        self.amount = amount
        self.contract = contract
        self.from = from
    }
}

/**
 Card 전송 트랜잭션 요청 정보
 */
public struct CardTxRequest: KlipRequest {
    /**
     전송받을 주소
     */
    public let to: String
    /**
     전송할 contract 주소
     */
    public let contract: String
    /**
     전송할 card id
     */
    public let cardId: String
    /**
     (optional) 송신자 주소
     */
    public let from: String?
    
    /**
     JSON 필드명
     */
    enum CodingKeys: String, CodingKey {
        case to, contract, from
        case cardId = "card_id"
    }
    
    /**
     요청에 필요한 정보들 초기화
     */
    public init(to: String, contract: String, cardId: String, from: String? = nil) {
        self.to = to
        self.contract = contract
        self.cardId = cardId
        self.from = from
    }
}

/**
 Contract 실행 트랜잭션 요청 정보
 */
public struct ContractTxRequest: KlipRequest {
    /**
     수신자 주소
     */
    public let to: String
    /**
     전송할 KLAY 금액
     */
    public let value: String
    /**
     실행할 Contract의 ABI
     */
    public let abi: String
    /**
     실행할 Contract의 ABI에 대한 Parameters
     */
    public let params: String
    /**
     (optional) 송신자 주소
     */
    public let from: String?
    
    /**
     요청에 필요한 정보들 초기화
     */
    public init(to: String, value: String, abi: String, params: String, from: String? = nil) {
        self.to = to
        self.value = value
        self.abi = abi
        self.params = params
        self.from = from
    }
}


