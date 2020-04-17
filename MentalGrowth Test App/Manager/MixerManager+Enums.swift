//
//  MixerManager+Enums.swift
//  MentalGrowth Test App
//
//  Created by Emil Karimov on 17.04.2020.
//  Copyright © 2020 Emil Karimov. All rights reserved.
//

import Foundation

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

enum PlayStatus {
    case play
    case pause
    case stop

    var title: String {
        switch self {
        case .play: return "Pause"
        case .pause: return "Play"
        case .stop: return "Play"
        }
    }
}
