//
//  PlaylistViewController.swift
//  MentalGrowth Test App
//
//  Created by Emil Karimov on 17/04/2020.
//  Copyright © 2020 Emil Karimov. All rights reserved.
//

import UIKit
import AVKit
import SnapKit

class PlaylistViewController: BaseViewController {

    enum VideoSection {
        case main
    }

    var presenter: PlaylistPresenterProtocol!

    private var videosTableView: UITableView!
    private var dataSource: UITableViewDiffableDataSource<VideoSection, MGPlaylistItemModel>!
    private var playerController: AVPlayerViewController!
    private var refreshControl = UIRefreshControl()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.createUI()
        self.refreshControl.beginRefreshing()
        self.presenter.viewLoaded()
    }

    private func createUI() {
        self.title = "Youtube Playlist"
        self.videosTableView = UITableView()
        self.videosTableView.register(PlaylistCell.self, forCellReuseIdentifier: PlaylistCell.getIdentifier())
        self.videosTableView.delegate = self
        self.videosTableView.dataSource = self
        self.videosTableView.rowHeight = UITableView.automaticDimension
        self.videosTableView.estimatedRowHeight = 100
        self.videosTableView.separatorStyle = .none
        
        self.refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        self.videosTableView.addSubview(refreshControl)

        self.playerController = AVPlayerViewController()

        self.configureDataSource()

        self.view.addSubview(self.videosTableView)
        self.videosTableView.snp.makeConstraints { (make) in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.left.right.bottom.equalToSuperview()
        }
    }

    private func configureDataSource() {
        let cellProvider: (UITableView, IndexPath, MGPlaylistItemModel) -> UITableViewCell? = { tableView, indexPath, model in
            let cell = tableView.dequeueReusableCell(withIdentifier: PlaylistCell.getIdentifier(), for: indexPath) as? PlaylistCellProtocol
            cell?.display(video: model)
            return cell
        }
        self.dataSource = UITableViewDiffableDataSource(tableView: self.videosTableView, cellProvider: cellProvider)
        self.dataSource.defaultRowAnimation = .fade
        var snapshot = NSDiffableDataSourceSnapshot<VideoSection, MGPlaylistItemModel>()
        snapshot.appendSections([.main])
        self.dataSource.apply(snapshot)
    }
}

// MARK: - Actions
extension PlaylistViewController {
    @objc private func refreshData() {
        self.presenter.reloadData()
    }
}

// MARK: - PlaylistViewProtocol
extension PlaylistViewController: PlaylistViewProtocol {

    func showPlaylist(videos: [MGPlaylistItemModel]) {
        var listSnapshot = self.dataSource.snapshot()
        listSnapshot.appendItems(videos, toSection: .main)
        self.dataSource.apply(listSnapshot, animatingDifferences: true)
        self.stopLoadingAnimation()
    }

    func playVideo(by link: URL) {
        let player = AVPlayer(url: link)
        self.playerController.player = player
        self.present(self.playerController, animated: true) {
            self.hideBaseLoading()
            player.play()
        }
    }

    func hideLoaderError(with error: String) {
        self.hideBaseLoading(with: .error, message: error)
    }
    
    func dropData() {
//        var listSnapshot = self.dataSource.snapshot()
//        listSnapshot.appendItems([], toSection: .main)
//        self.dataSource.apply(listSnapshot, animatingDifferences: true)
    }
    
    private func stopLoadingAnimation() {
        if self.refreshControl.isRefreshing {
            self.refreshControl.endRefreshing()
        }
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate
extension PlaylistViewController: UITableViewDataSource, UITableViewDelegate {

    func numberOfSections(in tableView: UITableView) -> Int {
        self.dataSource.numberOfSections(in: tableView)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.dataSource.tableView(tableView, numberOfRowsInSection: section)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        self.dataSource.tableView(tableView, cellForRowAt: indexPath)
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == self.dataSource.snapshot().numberOfItems - 3 {
            self.presenter.fetchNextPage()
        }
        
        let lastSectionIndex = tableView.numberOfSections - 1
        let lastRowIndex = tableView.numberOfRows(inSection: lastSectionIndex) - 1
        if indexPath.section ==  lastSectionIndex && indexPath.row == lastRowIndex {
            let spinner = UIActivityIndicatorView(style: .medium)
            spinner.startAnimating()
            spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: tableView.bounds.width, height: CGFloat(44))
            tableView.tableFooterView = spinner
            tableView.tableFooterView?.isHidden = false
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.showBaseLoading(with: "Loading player")
        let model = self.dataSource.snapshot().itemIdentifiers[indexPath.row]
        self.presenter.didSelect(model: model)
    }
}
