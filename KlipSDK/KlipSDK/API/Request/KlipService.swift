//
//  KlipService.swift
//  klip-sdk
//
//  Created by conan on 2020/09/07.
//  Copyright © 2020 conan. All rights reserved.
//

import Foundation

public typealias Parameters = [String: Any]
public typealias HTTPHeader = [HTTPHeaderField: String]

public protocol KlipServiceable {
    var url: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var header: HTTPHeader? { get }
    var query: Parameters? { get }
    var body: Data? { get }
    var encodingType: EncodingType { get }
    
    func request(urlRequest: inout URLRequest, quary: Parameters?, body: Data?, encodingType: EncodingType)
}

extension KlipServiceable {
    func request(urlRequest: inout URLRequest,
                 quary: Parameters? = nil,
                 body: Data? = nil,
                 encodingType: EncodingType
    ) {
        encodingType.encode(request: &urlRequest,
                            query: quary,
                            body: body)
    }
}

public enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}

public enum HTTPHeaderField: String {
    case authentication = "Authorization"
    case contentType = "Content-Type"
    case acceptType = "Accept"
    case acceptEncoding = "Accept-Encoding"
    case contentDisposition = "Content-Disposition"
}

/// This is default Content Type for convenient to use
public enum ContentType: String {
    case json = "application/json"
}
