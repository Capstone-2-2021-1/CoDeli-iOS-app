//
//  KlipError.swift
//  klip-sdk
//
//  Created by conan on 2020/09/07.
//  Copyright © 2020 conan. All rights reserved.
//

import Foundation

public struct KlipError: Codable {
    public let code: Int
    public let err: String
}
