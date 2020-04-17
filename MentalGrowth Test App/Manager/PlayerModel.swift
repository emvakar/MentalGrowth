//
//  PlayerModel.swift
//  MentalGrowth Test App
//
//  Created by Emil Karimov on 17.04.2020.
//  Copyright © 2020 Emil Karimov. All rights reserved.
//

import AVFoundation

class PlayerModel {

    let index: Int
    let player: AVAudioPlayerNode
    let file: AVAudioFile

    init(index: Int, player: AVAudioPlayerNode, file: AVAudioFile) {
        self.index = index
        self.player = player
        self.file = file
    }
}
