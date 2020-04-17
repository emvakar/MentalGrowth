//
//  MixerManager.swift
//  MentalGrowth Test App
//
//  Created by Emil Karimov on 17/04/2020.
//  Copyright © 2020 Emil Karimov. All rights reserved.
//

import AVFoundation

protocol AudioMixerManagerDelegate: class {
    func audioMixer(_ currentTrackPosition: Float, at tag: Int, currentTime: TimeInterval, overallTime: TimeInterval)
    func updateStatus(_ track: SoundtrackType, status: PlayStatus)
}

protocol AudioMixerManagerProtocol {

    var delegate: AudioMixerManagerDelegate? { get set }

    func play(track: SoundtrackType)
    func stop(track: SoundtrackType)
    func changeVolume(track: SoundtrackType, value: Float)
}

final class AudioMixerManager {

    weak var delegate: AudioMixerManagerDelegate?

    private var audioEngine: AVAudioEngine = AVAudioEngine()
    private var mixer: AVAudioMixerNode = AVAudioMixerNode()

    private var playerModels = [PlayerModel]()

    private var isSeeking = false
    private var timer: Timer?

    init() {
        self.setup()
    }

    private func setUpAudioSession() {
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, options: .mixWithOthers)
            try AVAudioSession.sharedInstance().setActive(true, options: .notifyOthersOnDeactivation)
        } catch let error {
            print(error)
        }
    }

    private func setup() {

        self.audioEngine.attach(self.mixer)

        // соединяем микшер с аудио выходом
        self.audioEngine.connect(self.mixer, to: self.audioEngine.mainMixerNode, format: nil)

        // переборка всех доступных треков
        for (indx, audioFile) in SoundtrackType.allCases.enumerated() {

            guard let audioFileUrl = Bundle.main.url(forResource: audioFile.value, withExtension: audioFile.ext) else { continue }

            let audioPlayer = AVAudioPlayerNode()
            audioPlayer.volume = 0.5
            self.audioEngine.attach(audioPlayer)

            // соединяем плеер к микшеру
            self.audioEngine.connect(audioPlayer, to: self.mixer, format: nil)

            do {
                let file = try AVAudioFile(forReading: audioFileUrl)
                audioPlayer.scheduleFile(file, at: nil, completionHandler: nil)

                print("[\(String(describing: self)) - \(audioFile)] prepared")
                let player = PlayerModel(index: indx, player: audioPlayer, file: file)
                self.playerModels.append(player)
            } catch let error {
                print(error.localizedDescription)
            }
        }

        self.audioEngine.prepare()
        do {
            try audioEngine.start()
        } catch let error {
            print(error.localizedDescription)
        }

        self.setUpAudioSession()
        print("[\(String(describing: self))] loaded!")

        self.startUpdater()

        self.timeUpdater(firstLaunch: true)
    }

    private func getPlayer(for type: SoundtrackType) -> PlayerModel? {
        guard self.playerModels.count > type.rawValue else { return nil }
        return self.playerModels[type.rawValue]
    }

    private func startUpdater() {

        guard self.timer == nil else { return }
        self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timeUpdater(firstLaunch:)), userInfo: nil, repeats: true)

    }

    @objc private func timeUpdater(firstLaunch: Bool = false) {

        for model in self.playerModels {
            if model.player.currentFrame >= model.file.length {
                model.player.stop()
                break
            }

            if model.player.isPlaying || firstLaunch {

                let time = model.player.currentTime / model.file.duration
                DispatchQueue.main.async {
                    self.delegate?.audioMixer(Float(time), at: model.index, currentTime: model.player.currentTime, overallTime: model.file.duration)
                }
                debugPrint(Float(time))
            }
        }

    }
}

// MARK: - PlayerManagerProtocol
extension AudioMixerManager: AudioMixerManagerProtocol {

    func play(track: SoundtrackType) {
        guard let model = self.getPlayer(for: track) else { return }
        if model.player.isPlaying {
            model.player.pause()
            print("[player \(track.rawValue)] is paused")
            self.delegate?.updateStatus(track, status: .pause)
        } else {
            model.player.play()
            print("[player \(track.rawValue)] is played")
            self.delegate?.updateStatus(track, status: .play)
        }
    }

    func stop(track: SoundtrackType) {
        guard let model = self.getPlayer(for: track) else { return }
        model.player.stop()
        self.delegate?.updateStatus(track, status: .stop)
    }

    func changeVolume(track: SoundtrackType, value: Float) {
        guard let model = self.getPlayer(for: track) else { return }
        model.player.volume = value
    }
}
