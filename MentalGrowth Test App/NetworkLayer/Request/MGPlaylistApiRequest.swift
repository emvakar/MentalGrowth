//
//  MGPlaylistApiRequest.swift
//  MentalGrowth Test App
//
//  Created by Emil Karimov on 17/04/2020.
//  Copyright © 2020 Emil Karimov. All rights reserved.
//

import Foundation
import EKNetworking

/// Запрос получение плейлиста
struct MGPlaylistApiRequest: EKNetworkRequest {

    var pageToken: String?
    
    var path: String {
        return "/playlistItems"
    }

    var method: EKRequestHTTPMethod {
        return .get
    }

    var urlParameters: [String: Any] {
        var params: [String: Any] = ["part": "snippet", "key": Constaints.APIKEY.youtube.rawValue, "playlistId": Constaints.Playlists.lebedev.rawValue, "maxResults": 50]
        if let value = self.pageToken {
            params.updateValue(value, forKey: "pageToken")
        }
        return params
    }

    var bodyParameters: [String: Any] {
        return [:]
    }

    var headers: [EKHeadersKey: String] {
        return HTTPHeaderHelper.getHeader()
    }
}
