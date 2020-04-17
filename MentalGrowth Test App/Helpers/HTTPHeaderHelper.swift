//
//  HTTPHeaderHelper.swift
//  MentalGrowth Test App
//
//  Created by Emil Karimov on 17/04/2020.
//  Copyright © 2020 Emil Karimov. All rights reserved.
//

import Foundation
import EKNetworking

class HTTPHeaderHelper {
    
    static func getHeader() -> [EKHeadersKey: String] {
        
        let headers = [EKHeadersKey.content_type: "application/json",
                       EKHeadersKey.api: "1.0.0",
                       EKHeadersKey.os: "iOS"]
        return headers
    }
}

