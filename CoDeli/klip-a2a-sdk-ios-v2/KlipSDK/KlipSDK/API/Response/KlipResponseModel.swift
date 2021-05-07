//
//  KlipResponse.swift
//  klip-sdk
//
//  Created by conan on 2020/09/07.
//  Copyright © 2020 conan. All rights reserved.
//

import Foundation

public enum ResponseType {
    case success
    case failure
}

public struct PrepareResponseModel: Codable {
    let requestKey: String
    let status: String
    let expirationTime: TimeInterval
    var result: KlipResult?
    var error: KlipError?
    
    enum CodingKeys: String, CodingKey {
        case requestKey = "request_key"
        case status, result, error
        case expirationTime = "expiration_time"
    }
}

public struct GetResultResponseModel: Codable {
    let requestKey: String
    let status: String
    let expirationTime: TimeInterval
    var result: KlipResult?
    var error: KlipError?
    
    enum CodingKeys: String, CodingKey {
        case requestKey = "request_key"
        case status, result, error
        case expirationTime = "expiration_time"
    }
}

public struct KlipResponse {
    func result(_ response: HTTPURLResponse) -> ResponseType {
        switch response.statusCode {
        case 200..<300: return .success
        default: return .failure
        }
    }
}

//class KlipResponse: Codable {
//    let requestKey: String
//    let expirationTime: TimeInterval
//    let status: String
//    var result: KlipResult?
//    var error: KlipError?
//
//
//    init(json: String) throws {
//        do {
//            let data = try fromJson(json: json)
//            self.requestKey = data.requestKey
//            self.expirationTime = data.expirationTime
//            self.status = data.status
//
//            if(data.result != nil) {
//                self.result = data.result
//            }
//
//            if(data.error != nil) {
//                self.error = data.error
//            }
//        } catch {
//            throw error
//        }
//    }
//
//    func fromJson(json:String) throws -> KlipResponse {
//        guard let jsonFile = json.data(using: .utf8) else {
//            throw KlipException.invalidInput(input: json)
//        }
//        let decoder = JSONDecoder()
//
//        do {
//            let data = try decoder.decode(KlipResponse.self, from: jsonFile);
//            return data;
//        } catch {
//            throw error
//        }
//    }
//}
