//
//  KlipCallback.swift
//  klip-sdk
//
//  Created by conan on 2020/09/07.
//  Copyright © 2020 conan. All rights reserved.
//

import Foundation

/**
 Klip 요청 결과 콜백
 */
public enum KlipCallback<Value> {
    /**
     성공시에 전달되는 callback
     */
    case success(Value)
    /**
     실패시에 전달되는 callback
     */
    case failure(ResponseErrorModel?)
    
    var value: Value? {
        switch self {
        case .success(let value): return value
        case .failure: return nil
        }
    }
    
    var error: ResponseErrorModel? {
        switch self {
        case .success: return nil
        case .failure(let ResponseErrorModel): return ResponseErrorModel
        }
    }
}
