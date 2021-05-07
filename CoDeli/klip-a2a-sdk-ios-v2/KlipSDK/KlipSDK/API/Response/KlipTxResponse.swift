//
//  KlipResponse.swift
//  klip-sdk
//
//  Created by conan on 2020/09/07.
//  Copyright © 2020 conan. All rights reserved.
//

import Foundation

/**
 요청의 결과
 */
public struct KlipTxResponse: Codable {
    /**
     Klip 요청마다 발급되는 고유한 key
     */
    public let requestKey: String
    /**
     요청의 현재 상태
     상태에 따라 "prepare", "request", "completed" 값으로 구분
     */
    public let status: String
    /**
     request key의 만료 시간
     */
    public let expirationTime: TimeInterval
    /**
     Klip 요청 성공에 대한 결과
     */
    public var result: PrepareResult?
    
    /**
     JSON 필드명
     */
    enum CodingKeys: String, CodingKey {
        case requestKey = "request_key"
        case status, result
        case expirationTime = "expiration_time"
    }
}
