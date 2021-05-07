//
//  PrepareService.swift
//  klip-sdk
//
//  Created by conan on 2020/09/07.
//  Copyright © 2020 conan. All rights reserved.
//

import Foundation

struct PrepareService: KlipServiceable {
    var url: String
    var path: String
    var method: HTTPMethod
    var header: HTTPHeader?
    var query: Parameters?
    var body: Data?
    var encodingType: EncodingType
    
    static func create(body: Data?) -> PrepareService {
        let domain = KlipDomain.create(authority: .api, version: .v2)
        return PrepareService(url: domain,
                              path: "/a2a/prepare",
                              method: .post,
                              header: nil,
                              query: nil,
                              body: body,
                              encodingType: .body)
    }
}

