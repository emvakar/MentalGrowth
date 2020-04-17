//
//  PlaylistCell.swift
//  MentalGrowth Test App
//
//  Created by Emil Karimov on 17/04/2020.
//  Copyright © 2020 Emil Karimov. All rights reserved.
//

import UIKit
import Kingfisher

protocol PlaylistCellProtocol: UITableViewCell {
    
    func display(video: MGPlaylistItemModel)
}

class PlaylistCell: UITableViewCell {
    
    private var thumbImageView: UIImageView!
    private var videoTitleLabel: UILabel!
    private var videoChannelTitleLabel: UILabel!
    private var videoDateTitleLabel: UILabel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.createUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func createUI() {
        
        self.selectionStyle = .none
        
        self.thumbImageView = UIImageView()
        
        self.videoTitleLabel = UILabel.makeLabel(size: 14, weight: .regular, color: .black)
        self.videoTitleLabel.numberOfLines = 0
        self.videoTitleLabel.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        
        self.videoChannelTitleLabel = UILabel.makeLabel(size: 14, weight: .light, color: .black)
        self.videoDateTitleLabel = UILabel.makeLabel(size: 14, weight: .light, color: .black)
        
        self.contentView.addSubview(self.thumbImageView)
        self.contentView.addSubview(self.videoTitleLabel)
        self.contentView.addSubview(self.videoChannelTitleLabel)
        self.contentView.addSubview(self.videoDateTitleLabel)
        
        self.thumbImageView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(5)
            make.top.equalToSuperview().offset(5)
            make.bottom.equalToSuperview().offset(-5)
            make.height.equalTo(100)
            make.width.equalTo(self.thumbImageView.snp.height).multipliedBy(1.78)
        }
        
        self.videoTitleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.thumbImageView.snp.right).offset(5)
            make.top.equalToSuperview().offset(5)
            make.right.equalToSuperview().offset(-5)
            make.bottom.equalTo(self.videoChannelTitleLabel.snp.top).offset(5)
        }
        
        self.videoChannelTitleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.thumbImageView.snp.right).offset(5)
            make.top.equalTo(self.videoTitleLabel.snp.bottom).offset(3)
            make.right.equalToSuperview().offset(-5)
            make.bottom.equalTo(self.videoDateTitleLabel.snp.top).offset(3)
            make.height.equalTo(15)
        }
        
        self.videoDateTitleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.thumbImageView.snp.right).offset(5)
            make.top.equalTo(self.videoChannelTitleLabel.snp.bottom).offset(3)
            make.right.equalToSuperview().offset(-5)
            make.bottom.equalToSuperview().offset(-5)
            make.height.equalTo(15)
        }
    }
}

// MARK: - PlaylistCellProtocol
extension PlaylistCell: PlaylistCellProtocol {
    
    func display(video: MGPlaylistItemModel) {
        
        self.videoTitleLabel.text = video.videoTitle ?? "N/A"
        self.videoChannelTitleLabel.text = video.channelTitle ?? "N/A"
        self.videoDateTitleLabel.text = video.videoDate ?? "N/A"
        if let stringUrl = video.thumbImageUrl, let url = URL(string: stringUrl) {
            self.thumbImageView.kf.setImage(with: url)
        }
    }
}
