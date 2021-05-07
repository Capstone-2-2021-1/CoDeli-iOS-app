//
//  KlipEncoder.swift
//  klip-sdk
//
//  Created by conan on 2020/09/07.
//  Copyright © 2020 conan. All rights reserved.
//

import Foundation

public enum EncodingType {
    case query
    case body
    case queryAndBody
}

extension EncodingType {
    func encode(request urlRequest: inout URLRequest,
                query: Parameters? = nil,
                body: Data? = nil
    ) {
        switch self {
        case .query:
            guard let query = query else { return }
            urlRequest.url = urlRequest.url?.withQueries(query)
        case .body:
            guard let body = body else { return }
            urlRequest.httpBody = body
        case .queryAndBody:
            guard
                let query = query,
                let body = body else { return }
            urlRequest.url = urlRequest.url?.withQueries(query)
            urlRequest.httpBody = body
        }
    }
}
