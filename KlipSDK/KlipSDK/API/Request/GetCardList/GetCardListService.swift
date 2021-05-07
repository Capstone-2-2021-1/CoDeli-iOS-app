//
//  GetCardListService.swift
//  KlipSDK
//
//  Created by conan on 2020/09/08.
//  Copyright © 2020 conan. All rights reserved.
//

import Foundation

struct GetCardListService: KlipServiceable {
    var url: String
    var path: String
    var method: HTTPMethod
    var header: HTTPHeader?
    var query: Parameters?
    var body: Data?
    var encodingType: EncodingType
    
    static func create(query: Parameters?) -> GetCardListService {
        let domain = KlipDomain.create(authority: .api, version: .v2)
        return GetCardListService(url: domain,
                                  path: "/a2a/cards",
                                  method: .get,
                                  header: nil,
                                  query: query,
                                  encodingType: .query
        )
    }
}
