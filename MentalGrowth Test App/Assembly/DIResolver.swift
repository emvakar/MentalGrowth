//
//  DIResolver.swift
//  MentalGrowth Test App
//
//  Created by Emil Karimov on 17/04/2020.
//  Copyright © 2020 Emil Karimov. All rights reserved.
//

import UIKit

protocol DIResolverComponents {
    func rootViewController() -> RootViewController
    func getAudioMixer() -> AudioMixerManagerProtocol
}

class DIResolver {
    private let audioMixer: AudioMixerManagerProtocol
    init(audioMixer: AudioMixerManagerProtocol) {
        self.audioMixer = audioMixer
    }
}

// MARK: - DIResolverComponents

extension DIResolver: DIResolverComponents {

    func rootViewController() -> RootViewController {
        let controller = RootViewController(resolver: self)
        return controller
    }

    func getAudioMixer() -> AudioMixerManagerProtocol {
        return self.audioMixer
    }
}
