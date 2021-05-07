//
//  KlipRemote.swift
//  klip-sdk
//
//  Created by conan on 2020/09/07.
//  Copyright © 2020 conan. All rights reserved.
//

import Foundation

public typealias DataCompletion = (_ data: Data?, _ error: ResponseErrorModel?) -> Void

public typealias JSONCompletion = (_ rawJSON: String?, _ error: ResponseErrorModel?) -> Void

public class KlipRemote {
    private let service: KlipServiceable
    
    public init(service: KlipServiceable) {
        self.service = service
    }
    
    @discardableResult
    public func request(completion: @escaping DataCompletion) -> URLSessionDataTask {
        var dataTask = URLSessionDataTask()
        do {
            let urlRequest = try makeURLRequest()
            dataTask = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
                guard let data = data, let response = response as? HTTPURLResponse, error == nil else {
                    return completion(nil, ResponseErrorModel(errorCode: KlipClientError.clientErrorCode.rawValue, errorMsg: error!.localizedDescription, httpStatus: 500))
                }
                let statusCode = response.statusCode
                
                switch KlipResponse().result(response) {
                case .success:
                    completion(data, nil)
                case .failure:
                    do {
                        let errorData = try JSONDecoder().decode(KlipResponseErrorModel.self,
                                                                 from: data)
                        completion(data, ResponseErrorModel(errorCode: errorData.code, errorMsg: errorData.err, httpStatus: statusCode))
                    } catch {
                        completion(data, ResponseErrorModel(errorCode: KlipClientError.clientErrorCode.rawValue, errorMsg: error.localizedDescription, httpStatus: statusCode))
                    }
                }
            }
            dataTask.resume()
        } catch {
            completion(nil, ResponseErrorModel(errorCode: KlipClientError.clientErrorCode.rawValue, errorMsg: error.localizedDescription, httpStatus: 500))
        }
        return dataTask
    }
    
    private func makeURLRequest() throws -> URLRequest {
        let url = URL(string: service.url + service.path)!
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = service.method.rawValue
        service.request(urlRequest: &urlRequest,
                        quary: service.query,
                        body: service.body,
                        encodingType: service.encodingType)
        setHeaderField(&urlRequest, header: service.header)
        return urlRequest
    }
    
    private func setHeaderField(_ urlRequest: inout URLRequest, header: HTTPHeader?) {
        urlRequest.setValue(
            ContentType.json.rawValue,
            forHTTPHeaderField: HTTPHeaderField.acceptType.rawValue
        )
        urlRequest.setValue(
            ContentType.json.rawValue,
            forHTTPHeaderField: HTTPHeaderField.contentType.rawValue
        )
        guard let header = header else { return }
        for (key, value) in header {
            urlRequest.setValue(value, forHTTPHeaderField: key.rawValue)
        }
    }
}
