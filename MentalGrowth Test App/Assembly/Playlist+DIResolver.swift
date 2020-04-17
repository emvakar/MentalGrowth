//
//  DIResolver+Playlist.swift
//  MentalGrowth Test App
//
//  Created by Emil Karimov on 17/04/2020.
//  Copyright © 2020 Emil Karimov. All rights reserved.
//

import UIKit

// MARK: - Playlist
protocol PlaylistProtocol {
    func presentPlaylistViewController() -> UIViewController
}

extension DIResolver: PlaylistProtocol {
    func presentPlaylistViewController() -> UIViewController {
        let viewController = PlaylistViewController()
        let interactor = PlaylistInteractor(networkController: self.getNetworking(), linkWrapper: self.getYoutubeLinkExtractor())
        let wireFrame = PlaylistWireFrame(resolver: self)
        let presenter = PlaylistPresenter(view: viewController, wireFrame: wireFrame, interactor: interactor)
        viewController.presenter = presenter
        return viewController
    }
}
