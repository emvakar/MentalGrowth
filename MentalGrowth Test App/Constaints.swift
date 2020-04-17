//
//  Constaints.swift
//  MentalGrowth Test App
//
//  Created by Emil Karimov on 17/04/2020.
//  Copyright © 2020 Emil Karimov. All rights reserved.
//

import Foundation

enum Constaints {
    
}

extension Constaints {
    
    enum APIKEY: String {
        case youtube = "AIzaSyArjoqszICbIxFf1wrSrgg-FbALOo_rm28"
    }
}

extension Constaints {
    
    enum Playlists: String {
        case lebedev = "PLmlTp5uCBYk7w6pryTr-Bd4SUZUvG4fQj"
    }
}

extension Constaints {
    
    enum YoutubeConstaint: String {
        case videoUrl = "https://youtu.be/"
        case apiBaseUrl = "https://www.googleapis.com/youtube/v3"
    }
}
