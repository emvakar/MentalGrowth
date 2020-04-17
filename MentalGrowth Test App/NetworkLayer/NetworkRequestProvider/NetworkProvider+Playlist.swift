//
//  NetworkProvider+Playlist.swift
//  MentalGrowth Test App
//
//  Created by Emil Karimov on 17/04/2020.
//  Copyright © 2020 Emil Karimov. All rights reserved.
//

import Foundation
import EKNetworking

protocol NetworkPlaylistProtocol {
    
    func getPlaylist(pageToken: String?, completion: @escaping (MGPlaylistModel?, EKNetworkError?) -> Void)
}

extension NetworkRequestProvider: NetworkPlaylistProtocol {
    
    func getPlaylist(pageToken: String?, completion: @escaping (MGPlaylistModel?, EKNetworkError?) -> Void) {
        let request = MGPlaylistApiRequest(pageToken: pageToken)
        let youtubeUrl = Constaints.YoutubeConstaint.apiBaseUrl.rawValue
        
        self.runRequest(request, baseUrl: youtubeUrl, progressResult: nil) { (statusCode, data, networkError) in

            if let error = networkError {
                completion(nil, error)
                return
            }
            do {
                if let data = data {
                    let jsonDecoder = JSONDecoder()
                    let jsonModel = try jsonDecoder.decode(MGPlaylistJSONModel.self, from: data)

                    let model = MGPlaylistModel.convert(apiModel: jsonModel)
                    completion(model, nil)
                }
            } catch {
                completion(nil, EKNetworkErrorStruct(error: error as NSError))
            }
        }
    }
}
