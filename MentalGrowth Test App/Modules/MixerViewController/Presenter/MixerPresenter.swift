//
//  MixerPresenter.swift
//  MentalGrowth Test App
//
//  Created by Emil Karimov on 17/04/2020.
//  Copyright © 2020 Emil Karimov. All rights reserved.
//

import Foundation

class MixerPresenter: BasePresenter {

    weak var view: MixerViewProtocol?
    private var wireFrame: MixerWireFrameProtocol
    private var interactor: MixerInteractorProtocol

    init(view: MixerViewProtocol, wireFrame: MixerWireFrameProtocol, interactor: MixerInteractorProtocol) {
        self.view = view
        self.interactor = interactor
        self.wireFrame = wireFrame
    }
}

// MARK: - MixerPresenterProtocol
extension MixerPresenter: MixerPresenterProtocol {

    func didClickPlay(tag: Int) {
        guard let track = SoundtrackType(rawValue: tag) else { return }
        self.interactor.didClickPlay(track: track)
    }

    func didChange(volume: Float, at tag: Int) {
        guard let track = SoundtrackType(rawValue: tag) else { return }
        self.interactor.didChange(volume: volume, at: track)
    }
}

// MARK: - AudioMixerManagerDelegate
extension MixerPresenter: AudioMixerManagerDelegate {

    func audioMixer(_ currentTrackPosition: Float, at tag: Int, currentTime: TimeInterval, overallTime: TimeInterval) {
        self.view?.updateLabel(on: tag, with: self.formatted(time: Float(currentTime)), and: self.formatted(time: Float(overallTime) - Float(currentTime)))
        self.view?.setProgress(on: tag, with: currentTrackPosition)
    }

    func updateStatus(_ track: SoundtrackType, status: PlayStatus) {
        self.view?.changeTitle(on: track.rawValue, status: status)
    }
}

// MARK: - Private
extension MixerPresenter {

    private func formatted(time: Float) -> String {
        var secs = Int(ceil(time))
        var hours = 0
        var mins = 0

        if secs > 3600 {
            hours = secs / 3600
            secs -= hours * 3600
        }

        if secs > 60 {
            mins = secs / 60
            secs -= mins * 60
        }

        var formattedString = ""
        if hours > 0 {
            formattedString = "\(String(format: "%02d", hours)):"
        }
        formattedString += "\(String(format: "%02d", mins)):\(String(format: "%02d", secs))"
        return formattedString
    }
}
