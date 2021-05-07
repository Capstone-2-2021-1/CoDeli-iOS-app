//
//  KlipErrorResponse.swift
//  klip-sdk
//
//  Created by conan on 2020/09/07.
//  Copyright © 2020 conan. All rights reserved.
//

import Foundation

public struct KlipResponseErrorModel: Codable {
    public let code: Int
    public let err: String
}

/**
 * Klip 에러 정보
 */
public struct ResponseErrorModel: Codable {
    /**
     에러 코드
     */
    public let errorCode: Int
    /**
     에러 메세지
     */
    public let errorMsg: String
    /**
     HTTP Status Code
     */
    public let httpStatus: Int
    
    public init(errorCode: Int, errorMsg: String, httpStatus: Int) {
        self.errorCode = errorCode
        self.errorMsg = errorMsg
        self.httpStatus = httpStatus
    }
}

public enum KlipClientError: Int, Error {
    case clientErrorCode = 10
    case coreParameterMissing = 11
}

public enum KlipServerError: Int, Error {
    case requestKeyDoseNotExist = 6000
    case requestKeyIsExpired = 6001
    case invalidRequestType = 6010
    case executeContractCountDailyLimitExceeded = 6200
    case bappNameIsRequired = 6401
    case invalidTransaction = 6402
    case invalidToAddress = 6403
    case invalidAmount = 6404
    case invalidContract = 6405
    case invalidCardId = 6406
    case invalidAbi = 6407
    case invalidParams = 6408
    case invalidValue = 6409
    case unknownRequestType = 6410
}
