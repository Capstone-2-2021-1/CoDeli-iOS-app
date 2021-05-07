//
//  Klip.swift
//  klip-sdk
//
//  Created by conan on 2020/09/07.
//  Copyright © 2020 conan. All rights reserved.
//

import Foundation
import UIKit


/**
 클래스에서 객체를 생성하여 Klip API를 사용할 수 있다.
 */

public final class KlipSDK {
    private static var environment: KlipEnvironment = .prod
    /**
     싱글톤을 적용한 클래스로 shared 변수를 이용해서 KlipSDK 객체를 초기화하고 얻을 수 있다.
     */
    public static let shared = KlipSDK()
    public func setEnvironment(env: KlipEnvironment) {
        KlipSDK.environment = env
    }
    public func getEnvironment() -> KlipEnvironment {
        return KlipSDK.environment
    }
    init() {}
    
    /**
     App2App에 요청할 사용자 요청 정보를 미리 등록하여 준비하기 위한 메소드로, 해당 메소드를 통해 reqeust key를 발급 받을 수 있다.
     
     - Parameter
     - request: KlipRequet 타입의 인자로 Auth, KLAY, Token, Card, Contract Execution 중 하나의 타입을 갖게 된다.
     - bappInfo: BAppInfo 타입의 인자로 BAppInfo에는 BApp의 이름(필수)과 성공, 실패시에 돌아올 callback link 정보를 넣어줄 수 있다.
     - completion:  결과를 받을  completion으로 실패시에는 error정보를 담은 ResponseErrorModel를 반환받고, 성공시에 KlipTxResponse객체를 응답 받는다.
     */
    public func prepare(request: KlipRequest,
                        bappInfo: BAppInfo,
                        completion: @escaping(KlipCallback<KlipTxResponse>) -> Void
    ) {
        do {
            var body: Data?
            if request is AuthRequest {
                body = try PrepareRequest<AuthRequest>(type: PrepareType.auth, bapp: bappInfo).toJson()
            } else if request is KlayTxRequest {
                let klaytTxRequest = request as? KlayTxRequest
                body = try PrepareRequest<KlayTxRequest>(type: PrepareType.sendKlay, bapp: bappInfo, transaction: klaytTxRequest).toJson()
            } else if request is TokenTxRequest {
                let tokenTxRequest = request as? TokenTxRequest
                body = try PrepareRequest<TokenTxRequest>(type: PrepareType.sendFT, bapp: bappInfo, transaction: tokenTxRequest).toJson()
            } else if request is CardTxRequest {
                let cardTxRequest = request as? CardTxRequest
                body = try PrepareRequest<CardTxRequest>(type: PrepareType.sendCard, bapp: bappInfo, transaction: cardTxRequest).toJson()
            } else if request is ContractTxRequest {
                let contractTxRequest = request as? ContractTxRequest
                body = try PrepareRequest<ContractTxRequest>(type: PrepareType.contractExecution, bapp: bappInfo, transaction: contractTxRequest).toJson()
            }
            
            let service = PrepareService.create(body: body)
            self.remote(service: service, completion: completion)
        } catch {
            completion(KlipCallback.failure(ResponseErrorModel(errorCode: KlipClientError.clientErrorCode.rawValue, errorMsg: error.localizedDescription, httpStatus: 500)))
        }
    }
    
    /**
     prepare 메소드를 통해 등록해둔 요청을 실제 수행하도록 요청하는 메소드로 DeepLink를 이용하여 카카오톡을 통해 Klip이 실행되고, 사용자의 동의 또는 서명을 받는다.
     
     - Parameter
     - requestKey: prepare 메소드를 통해 얻은 requestKey
     */
    public func request(requestKey: String) -> Void {
        if let appURL = URL(string: getLinkUrl() + requestKey) {
            if UIApplication.shared.canOpenURL(appURL) {
                UIApplication.shared.open(appURL, options: [:]) { success in
                    if success {
                        print("The URL was delivered successfully.")
                    } else {
                        print("The URL failed to open.", appURL)
                    }
                }
            } else {
                let kakaoMarketURL = URL(string: "itms-apps://itunes.apple.com/app/id362057947")
                UIApplication.shared.open(kakaoMarketURL!, options: [:]) { success in
                    if success {
                        print("The URL was delivered successfully.")
                    } else {
                        print("The URL failed to open.", kakaoMarketURL!)
                    }
                }
            }
        } else {
            print("Invalid URL specified.")
        }
    }
    
    /**
     요청의 처리 결과를 조회
     
     - Parameter
     - requestKey: prepare 메소드를 통해 얻은 requestKey
     - completion:  결과를 받을  completion으로 실패시에는 error정보를 담은 ResponseErrorModel를 반환받고, 성공시에 KlipTxResponse객체를 응답 받는다.
     */
    public func getResult(requestKey: String, completion: @escaping(KlipCallback<KlipTxResponse>) -> Void)
    {
        let queryParams = GetResultRequest(requestKey: requestKey).getParams()
        let service = GetResultService.create(query: queryParams)
        self.remote(service: service, completion: completion)
    }
    
    /**
     사용자가 보유한 카드 목록을 조회
     
     - Parameter
     - cardAddress: 조회하는 카드 주소
     - userAddress: 조회하는 사용자 EOA
     - cursor: 카드 갯수가 100개 이상일 경우 다음 카드 최대 100개를 요청하기 위한 cursor
     - completion:  결과를 받을  completion으로 실패시에는 error정보를 담은 ResponseErrorModel를 반환받고, 성공시에 CardListResponse객체를 응답 받는다.
     */
    public func getCardList(cardAddress: String, userAddress: String, cursor: String?, completion: @escaping(KlipCallback<CardListResponse>) -> Void)
    {
        if (cardAddress.isEmpty || userAddress.isEmpty) {
            completion(KlipCallback.failure(ResponseErrorModel(errorCode: KlipClientError.coreParameterMissing.rawValue, errorMsg: "clientError", httpStatus: 500)))
        }
        let queryParams = GetCardListRequest(cardAddress: cardAddress, userAddress: userAddress, cursor: cursor).getParams()
        let service = GetCardListService.create(query: queryParams)
        self.remote(service: service, completion: completion)
    }
    
    private func getLinkUrl() -> String{
        let linkUrl = KlipDomain.create(authority: .link)
        return linkUrl
    }
    
    private func remote<T: Codable> (service: KlipServiceable,
                                     completion: @escaping(KlipCallback<T>) -> Void
    ) {
        KlipRemote(service: service).request { data, error in
            guard let responseData = data, error == nil else {
                return completion(KlipCallback.failure(error))
            }
            do {
                let resultData = try JSONDecoder().decode(T.self,
                                                          from: responseData)
                completion(KlipCallback.success(resultData))
            } catch {
                completion(KlipCallback.failure(ResponseErrorModel(errorCode: KlipClientError.clientErrorCode.rawValue, errorMsg: error.localizedDescription, httpStatus: 500)))
            }
        }
    }
    
}
