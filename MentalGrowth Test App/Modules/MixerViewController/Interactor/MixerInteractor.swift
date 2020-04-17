//
//  MixerInteractor.swift
//  MentalGrowth Test App
//
//  Created by Emil Karimov on 17/04/2020.
//  Copyright © 2020 Emil Karimov. All rights reserved.
//

class MixerInteractor: BaseInteractor {

    private var mixer: AudioMixerManagerProtocol

    init(mixer: AudioMixerManagerProtocol) {
        self.mixer = mixer
    }
}

extension MixerInteractor: MixerInteractorProtocol {
    func didClickPlay(track: SoundtrackType) {
        self.mixer.play(track: track)
    }
    
    func didChange(volume: Float, at track: SoundtrackType) {
        self.mixer.changeVolume(track: track, value: volume)
    }
}
