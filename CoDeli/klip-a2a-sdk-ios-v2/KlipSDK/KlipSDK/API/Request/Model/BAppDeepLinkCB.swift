//
//  BAppDeepLinkCB.swift
//  klip-sdk
//
//  Created by conan on 2020/09/07.
//  Copyright © 2020 conan. All rights reserved.
//

import Foundation

/**
 요청 BApp의 처리 결과 Callback URL
 */
public struct BAppDeepLinkCB: Codable {
    /**
     (optional) 요청 BApp의 처리 결과가 성공일때 Callback URL
     */
    public let success: String?
    /**
     (optional) 요청 BApp의 처리 결과가 실패일때 Callback URL
     */
    public let fail: String?
    
    /**
     요청에 필요한 정보들 초기화
     */
    public init(successURL: String? = nil, failURL: String? = nil) {
        self.success = successURL
        self.fail = failURL
    }
}
