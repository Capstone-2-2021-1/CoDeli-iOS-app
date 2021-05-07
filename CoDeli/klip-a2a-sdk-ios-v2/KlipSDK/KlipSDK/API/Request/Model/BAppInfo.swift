//
//  BAppInfo.swift
//  klip-sdk
//
//  Created by conan on 2020/09/07.
//  Copyright © 2020 conan. All rights reserved.
//

import Foundation

/**
 요청 BApp 정보
 */
public struct BAppInfo: Codable {
    /**
     요청 BApp 이름
     */
    public let name: String
    /**
     (optional) 요청의 처리 결과 Callback URL 정보
     */
    public let callback: BAppDeepLinkCB?
    
    /**
     요청에 필요한 정보들 초기화
     */
    public init(name: String, callback: BAppDeepLinkCB? = nil) {
        self.name = name
        self.callback = callback
    }
}
