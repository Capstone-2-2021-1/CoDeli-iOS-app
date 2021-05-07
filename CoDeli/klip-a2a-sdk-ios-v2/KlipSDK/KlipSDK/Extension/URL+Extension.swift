//
//  Extension.swift
//  klip-sdk
//
//  Created by conan on 2020/09/07.
//  Copyright © 2020 conan. All rights reserved.
//

import Foundation

extension URL {
    func withQueries(_ queries: [String: Any]) -> URL? {
        var components = URLComponents(url: self, resolvingAgainstBaseURL: true)
        components?.queryItems = queries.map {
            URLQueryItem(
                name: $0.key,
                value: "\($0.value)"
                    .addingPercentEncoding(
                        withAllowedCharacters: .urlQueryAllowed
            ))
        }
        return components?.url
    }
}
