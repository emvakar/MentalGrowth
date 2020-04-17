//
//  AVAudio+Extension.swift
//  MentalGrowth Test App
//
//  Created by Emil Karimov on 17.04.2020.
//  Copyright © 2020 Emil Karimov. All rights reserved.
//

import AVFoundation

extension AVAudioFile {

    var duration: TimeInterval {
        let sampleRateSong = Double(processingFormat.sampleRate)
        let lengthSongSeconds = Double(length) / sampleRateSong
        return lengthSongSeconds
    }

}

extension AVAudioPlayerNode {

    var currentFrame: AVAudioFramePosition {

        guard
            let lastRenderTime = self.lastRenderTime,
            let playerTime = self.playerTime(forNodeTime: lastRenderTime)
            else {
                return 0
        }

        return playerTime.sampleTime
    }

    var currentTime: TimeInterval {
        get {
            if let nodeTime: AVAudioTime = self.lastRenderTime, let playerTime: AVAudioTime = self.playerTime(forNodeTime: nodeTime) {
                return Double(Double(playerTime.sampleTime) / playerTime.sampleRate)
            }
            return 0
        }
    }
}
