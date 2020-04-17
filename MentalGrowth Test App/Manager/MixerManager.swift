//
//  MixerManager.swift
//  MentalGrowth Test App
//
//  Created by Emil Karimov on 17.04.2020.
//  Copyright © 2020 Emil Karimov. All rights reserved.
//

import Foundation
import AVFoundation
import AVKit
import MediaPlayer

enum SoundtrackType: Int, CaseIterable {

    case sound1 = 0
    case sound2
    case sound3

    var value: String {
        switch self {
        case .sound1: return "Creeping_Spiders"
        case .sound2: return "I_Feel_Like_Partying_Right_Now"
        case .sound3: return "The_DeLong_Incident"
        }
    }

    var ext: String { "mp3" }
}

protocol AudioMixerManagerProtocol {

    func play(track: SoundtrackType)
    func stop(track: SoundtrackType)

    func changeVolume(track: SoundtrackType, value: Float)
}

final class AudioMixerManager {

    private var audioEngine: AVAudioEngine = AVAudioEngine()
    private var mixer: AVAudioMixerNode = AVAudioMixerNode()

    private var players = [AVAudioPlayerNode]()

    init() {
        self.setup()


    }

    func setUpAudioSession() {
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, options: .mixWithOthers)
            try AVAudioSession.sharedInstance().setActive(true, options: .notifyOthersOnDeactivation)
        } catch let error {
            print(error)
        }
    }

    private func setup() {

        do {
            self.audioEngine.attach(self.mixer)
            self.audioEngine.connect(self.mixer, to: self.audioEngine.outputNode, format: nil)

            try self.audioEngine.start()

            for audioFile in SoundtrackType.allCases {

                guard let audioFileUrl = Bundle.main.url(forResource: audioFile.value, withExtension: audioFile.ext) else { continue }

                let audioPlayer = AVAudioPlayerNode()
                audioPlayer.volume = 0.3
                self.audioEngine.attach(audioPlayer)

                self.audioEngine.connect(audioPlayer, to: self.mixer, format: nil)

                do {
                    let file = try AVAudioFile(forReading: audioFileUrl)
                    guard let buffer = AVAudioPCMBuffer(pcmFormat: file.processingFormat, frameCapacity: AVAudioFrameCount(file.length)) else { continue }
                    try file.read(into: buffer)

                    audioPlayer.scheduleBuffer(buffer, completionHandler: nil)

                    if audioPlayer.isPlaying {
                        print("[audioPlayer] is playing")
                    }
                    self.players.append(audioPlayer)
                } catch let error {
                    print(error.localizedDescription)
                }
            }
        } catch let error {
            print(error.localizedDescription)
        }
        self.audioEngine.prepare()
        self.setUpAudioSession()
        print("[\(String(describing: self))] loaded!")
    }

    private func getPlayer(for type: SoundtrackType) -> AVAudioPlayerNode? {
        guard self.players.count > type.rawValue else { return nil }

        return self.players[type.rawValue]
    }
}

// MARK: - PlayerManagerProtocol
extension AudioMixerManager: AudioMixerManagerProtocol {

    func play(track: SoundtrackType) {
        guard let player = self.getPlayer(for: track) else { return }
        if player.isPlaying {
            player.pause()
        } else {
            player.play()
        }
    }

    func stop(track: SoundtrackType) {
        guard let player = self.getPlayer(for: track) else { return }
        player.stop()
    }

    func changeVolume(track: SoundtrackType, value: Float) {
        guard let player = self.getPlayer(for: track) else { return }
        player.volume = value
    }
}
