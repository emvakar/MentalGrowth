//
//  PlaylistPresenter.swift
//  MentalGrowth Test App
//
//  Created by Emil Karimov on 17/04/2020.
//  Copyright © 2020 Emil Karimov. All rights reserved.
//

import UIKit

class PlaylistPresenter: BasePresenter {

    weak var view: PlaylistViewProtocol?
    private var wireFrame: PlaylistWireFrameProtocol
    private var interactor: PlaylistInteractorProtocol

    private var nextPageToken: String?

    init(view: PlaylistViewProtocol, wireFrame: PlaylistWireFrameProtocol, interactor: PlaylistInteractorProtocol) {
        self.view = view
        self.interactor = interactor
        self.wireFrame = wireFrame
        self.nextPageToken = nil
    }
}

extension PlaylistPresenter: PlaylistPresenterProtocol {

    func reloadData() {
        self.view?.dropData()
        self.nextPageToken = nil
        self.fetchNextPage()
    }

    func viewLoaded() {
        self.fetchNextPage()
    }

    func fetchNextPage() {
        self.interactor.fetchPlaylistNext(page: self.nextPageToken) { (playlistModel, error) in
            if let error = error {
                return
            }

            if let items = playlistModel?.items {
                self.view?.showPlaylist(videos: items)
            }
            self.nextPageToken = playlistModel?.nextPageToken
        }
    }

    func didSelect(model: MGPlaylistItemModel) {
        guard let vId = model.videoID else {
            return
        }
        self.interactor.getVideoLink(identifier: vId) { (videoLink, error) in
            if let error = error {
                self.view?.hideLoaderError(with: error.localizedDescription)
                return
            }
            if let stringLink = videoLink, let url = URL(string: stringLink) {
                DispatchQueue.main.async {
                    self.view?.playVideo(by: url)
                }
            }
        }
    }
}
