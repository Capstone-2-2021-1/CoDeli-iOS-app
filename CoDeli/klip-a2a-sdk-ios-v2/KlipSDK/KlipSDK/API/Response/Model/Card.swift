//
//  CardList.swift
//  KlipSDK
//
//  Created by conan on 2020/09/08.
//  Copyright © 2020 conan. All rights reserved.
//

import Foundation

/**
 Card 정보
 */
public struct Card: Codable {
    /**
     생성 시간
     */
    public let createdAt: Int;
    /**
     마지막 업데이트 시간
     */
    public let updatedAt: Int;
    /**
     현재 소유자 주소
     */
    public let owner: String;
    /**
     최근 송신자 주소
     */
    public let sender: String;
    /**
     카드의 고유 ID
     */
    public let cardId: Int;
    /**
     카드 상세정보가 저장된 URL
     */
    public let cardUri: String;
    /**
     트랜잭션 해시
     */
    public let transactionHash: String;
    
    /**
     JSON 필드명
     */
    enum CodingKeys: String, CodingKey {
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case owner, sender
        case cardId = "card_id"
        case cardUri = "card_uri"
        case transactionHash = "transaction_hash"
    }
}
