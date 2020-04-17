//
//  NetworkRequestProvider.swift
//  MentalGrowth Test App
//
//  Created by Emil Karimov on 17/04/2020.
//  Copyright © 2020 Emil Karimov. All rights reserved.
//

import Foundation
import EKNetworking

class NetworkRequestProvider {

    let networkWrapper: EKNetworkRequestWrapperProtocol

    private var lastResponse: Int = 200

    init(networkWrapper: EKNetworkRequestWrapperProtocol) {
        self.networkWrapper = networkWrapper
    }

    internal func runRequest(_ request: EKNetworkRequest, baseUrl: String, progressResult: ((Double) -> Void)?, completion: @escaping(_ statusCode: Int, _ requestData: Data?, _ error: EKNetworkError?) -> Void) {

        self.networkWrapper.runRequest(request, baseURL: baseUrl, authToken: nil, progressResult: progressResult) { [weak self] (statusCode, data, error) in
            guard let strongSelf = self else {
                completion(-700, nil, EKNetworkErrorStruct(statusCode: -700, data: nil))
                return
            }
            guard let error = error else {
                completion(statusCode, data, nil)
                strongSelf.lastResponse = statusCode
                return
            }

            switch error.type {
            case .unauthorized:

                if strongSelf.lastResponse == 401 {
                    completion(statusCode, nil, error)
                    return
                }
                strongSelf.lastResponse = statusCode
            default:
                strongSelf.lastResponse = statusCode
                completion(statusCode, nil, error)
            }
        }
    }
}

