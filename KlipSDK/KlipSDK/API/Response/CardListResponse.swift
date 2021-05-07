//
//  CardListResponse.swift
//  KlipSDK
//
//  Created by conan on 2020/09/08.
//  Copyright © 2020 conan. All rights reserved.
//

import Foundation

/**
 Card 목록
 */
public struct CardListResponse: Codable {
    /**
     카드 이름
     */
    public let name: String
    /**
     카드의 심볼 이미지 URL
     */
    public let symbolImg: String
    /**
     카드 목록
     */
    public let cards: [Card]
    /**
     추가로 가져올 수 있는 다음 카드 목록을 위한 커서
     이 값은 카드 목록이 100개 이상인 경우, 다음 카드 목록을 가져오기 위해 사용
     100개 이하일 경우 빈 문자열 반환
     */
    public let nextCursor: String
    
    /**
     JSON 필드명
     */
    enum CodingKeys: String, CodingKey {
        case symbolImg = "symbol_img"
        case name, cards
        case nextCursor = "next_cursor"
    }
    
    public func toJson() throws -> Data {
        do {
            return try JSONEncoder().encode(self)
        } catch {
            throw error
        }
    }
}

