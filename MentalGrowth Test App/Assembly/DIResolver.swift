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
    func getAudioMixer(delegate: AudioMixerManagerDelegate?) -> AudioMixerManagerProtocol
    func getNetworking() -> NetworkRequestProvider
    func getYoutubeLinkExtractor() -> YouTubeLinkWrapperProtocol
}

class DIResolver {

    private var audioMixer: AudioMixerManagerProtocol
    private let networking: NetworkRequestProvider
    private let youtubeLinkWrapper: YouTubeLinkWrapperProtocol

    init(audioMixer: AudioMixerManagerProtocol, networking: NetworkRequestProvider, youtubeLinkWrapper: YouTubeLinkWrapperProtocol) {
        self.audioMixer = audioMixer
        self.networking = networking
        self.youtubeLinkWrapper = youtubeLinkWrapper
    }
}

// MARK: - DIResolverComponents
extension DIResolver: DIResolverComponents {

    func rootViewController() -> RootViewController {
        let controller = RootViewController(resolver: self)
        return controller
    }

    func getAudioMixer(delegate: AudioMixerManagerDelegate?) -> AudioMixerManagerProtocol {
        self.audioMixer.delegate = delegate
        return self.audioMixer
    }

    func getNetworking() -> NetworkRequestProvider {
        return self.networking
    }

    func getYoutubeLinkExtractor() -> YouTubeLinkWrapperProtocol {
        return self.youtubeLinkWrapper
    }
}

