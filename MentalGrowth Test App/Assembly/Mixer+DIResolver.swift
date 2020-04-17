//
//  DIResolver+Mixer.swift
//  MentalGrowth Test App
//
//  Created by Emil Karimov on 17/04/2020.
//  Copyright © 2020 Emil Karimov. All rights reserved.
//

import UIKit

// MARK: - Mixer
protocol MixerProtocol {
    func presentMixerViewController() -> UIViewController
}

extension DIResolver: MixerProtocol {
    func presentMixerViewController() -> UIViewController {
        let viewController = MixerViewController()
        let interactor = MixerInteractor()
        let wireFrame = MixerWireFrame(resolver: self)
        let presenter = MixerPresenter(view: viewController, wireFrame: wireFrame, interactor: interactor, mixer: self.getAudioMixer())
        viewController.presenter = presenter
        return viewController
    }
}
