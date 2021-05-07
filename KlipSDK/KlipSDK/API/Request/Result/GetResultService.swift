//
//  GetResultService.swift
//  KlipSDK
//
//  Created by conan on 2020/09/08.
//  Copyright © 2020 conan. All rights reserved.
//

import Foundation

struct GetResultService: KlipServiceable {
    var url: String
    var path: String
    var method: HTTPMethod
    var header: HTTPHeader?
    var query: Parameters?
    var body: Data?
    var encodingType: EncodingType
    
    static func create(query: Parameters?) -> GetResultService {
        let domain = KlipDomain.create(authority: .api, version: .v2)
        return GetResultService(url: domain,
                                path: "/a2a/result",
                                method: .get,
                                header: nil,
                                query: query,
                                encodingType: .query
        )
    }
}
