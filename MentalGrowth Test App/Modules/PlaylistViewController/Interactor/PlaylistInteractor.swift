//
//  PlaylistInteractor.swift
//  MentalGrowth Test App
//
//  Created by Emil Karimov on 17/04/2020.
//  Copyright © 2020 Emil Karimov. All rights reserved.
//

import EKNetworking

class PlaylistInteractor: BaseInteractor {
    
    var networkController: NetworkPlaylistProtocol
    var linkWrapper: YouTubeLinkWrapperProtocol
    
    init(networkController: NetworkPlaylistProtocol, linkWrapper: YouTubeLinkWrapperProtocol) {
        self.networkController = networkController
        self.linkWrapper = linkWrapper
    }
}

extension PlaylistInteractor: PlaylistInteractorProtocol {
    
    func fetchPlaylistNext(page: String?, completion: @escaping (MGPlaylistModel?, EKNetworkError?) -> Void) {
        self.networkController.getPlaylist(pageToken: page, completion: completion)
    }
    
    func getVideoLink(identifier: String, completion: @escaping (String?, Error?) -> Void) {
        self.linkWrapper.getLink(from: identifier, completion: completion)
    }
}
