//
//  MixerPresenter.swift
//  MentalGrowth Test App
//
//  Created by Emil Karimov on 17/04/2020.
//  Copyright © 2020 Emil Karimov. All rights reserved.
//

class MixerPresenter: BasePresenter {

    weak var view: MixerViewProtocol?
    private var wireFrame: MixerWireFrameProtocol
    private var interactor: MixerInteractorProtocol
    private let mixer: AudioMixerManagerProtocol

    init(view: MixerViewProtocol, wireFrame: MixerWireFrameProtocol, interactor: MixerInteractorProtocol, mixer: AudioMixerManagerProtocol) {
        self.view = view
        self.interactor = interactor
        self.wireFrame = wireFrame
        self.mixer = mixer
    }
}

extension MixerPresenter: MixerPresenterProtocol {

    func didClickPlay(tag: Int) {
        guard let track = SoundtrackType(rawValue: tag) else { return }
        let status = self.mixer.play(track: track)
        self.view?.changeTitle(on: tag, status: status)

    }

    func didChange(volume: Float, at tag: Int) {
        guard let track = SoundtrackType(rawValue: tag) else { return }
        self.mixer.changeVolume(track: track, value: volume)
    }
}
