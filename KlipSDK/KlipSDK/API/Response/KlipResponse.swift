//
//  File.swift
//  KlipSDK
//
//  Created by conan on 2020/09/11.
//  Copyright © 2020 conan. All rights reserved.
//

import Foundation

public enum ResponseType {
    case success
    case failure
}

public struct KlipResponse {
    func result(_ response: HTTPURLResponse) -> ResponseType {
        switch response.statusCode {
        case 200..<300: return .success
        default: return .failure
        }
    }
}
