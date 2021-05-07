//
//  KlipProtocol.swift
//  KlipSDK
//
//  Created by conan on 2020/10/07.
//  Copyright © 2020 Ground1 Corp. All rights reserved.
//

import Foundation
import UIKit

struct KlipDomain {
    private static let scheme: String = "https://"
    private static let kakaoKlipLink: String = "/?target=/a2a?request_key="
    private static let environment = KlipSDK.shared.getEnvironment()
    
    static func create(authority: Authority, version: KlipVersion) -> String {
        let authority = environment.apiAuthority
        return scheme + authority + version.string
    }
    
    static func create(authority: Authority) -> String {
        let kakaoLink = environment.kakaoLink
        let authority = environment.linkAuthority
        return kakaoLink + scheme + authority + kakaoKlipLink
    }
}

public enum KlipEnvironment {
    case prod
    
    var apiAuthority: String {
        switch self {
        case .prod:
            return "a2a-api.klipwallet.com"
        }
    }
    
    var linkAuthority: String {
        switch self {
        case .prod:
            return "klipwallet.com"
        }
    }
    
    var kakaoLink: String {
        switch self {
        case .prod:
            return "kakaotalk://klipwallet/open?url="
        }
    }
}

enum KlipVersion {
    case v1
    case v2
    
    var string: String {
        switch self {
        case .v1:
            return "/v1"
        case .v2:
            return "/v2"
        }
    }
}

enum Authority {
    case api
    case link
}
