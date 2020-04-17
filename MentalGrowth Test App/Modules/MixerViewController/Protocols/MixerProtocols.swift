//
//  MixerProtocols.swift
//  MentalGrowth Test App
//
//  Created by Emil Karimov on 17/04/2020.
//  Copyright © 2020 Emil Karimov. All rights reserved.
//

import UIKit

// PRESENTER -> VIEW
protocol MixerViewProtocol: class {
    func changeTitle(on tag: Int, status: PlayStatus)
    func setProgress(on tag: Int, with value: Float)
    func updateLabel(on tag: Int, with currentTime: String, and overallTime: String)
}

// PRESENTER -> WIREFRAME
protocol MixerWireFrameProtocol: class { }

// VIEW -> PRESENTER
protocol MixerPresenterProtocol: class {
    func didClickPlay(tag: Int)
    func didChange(volume: Float, at tag: Int)
}

// PRESENTER -> INTERACTOR
protocol MixerInteractorProtocol: class {
    func didClickPlay(track: SoundtrackType)
    func didChange(volume: Float, at track: SoundtrackType)
}
