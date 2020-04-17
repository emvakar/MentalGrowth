//
//  PlaylistProtocols.swift
//  MentalGrowth Test App
//
//  Created by Emil Karimov on 17/04/2020.
//  Copyright © 2020 Emil Karimov. All rights reserved.
//

import UIKit
import EKNetworking

// PRESENTER -> VIEW
protocol PlaylistViewProtocol: class {
    func showPlaylist(videos: [MGPlaylistItemModel])
    func playVideo(by link: URL)
    func hideLoaderError(with error: String)
    func dropData()
}

// PRESENTER -> WIREFRAME
protocol PlaylistWireFrameProtocol: class { }

// VIEW -> PRESENTER
protocol PlaylistPresenterProtocol: class {
    
    func viewLoaded()
    func fetchNextPage()
    func didSelect(model: MGPlaylistItemModel)
    func reloadData()
}

// PRESENTER -> INTERACTOR
protocol PlaylistInteractorProtocol: class {
    func fetchPlaylistNext(page: String?, completion: @escaping (MGPlaylistModel?, EKNetworkError?) -> Void)
    func getVideoLink(identifier: String, completion: @escaping (String?, Error?) -> Void)
}
