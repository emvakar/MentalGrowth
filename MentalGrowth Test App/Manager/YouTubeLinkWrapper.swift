//
//  YouTubeLinkWrapper.swift
//  MentalGrowth Test App
//
//  Created by Emil Karimov on 17/04/2020.
//  Copyright © 2020 Emil Karimov. All rights reserved.
//

import Foundation
import YoutubeDirectLinkExtractor

protocol YouTubeLinkWrapperProtocol {
    func getLink(from videoId: String, completion: @escaping (String?, Error?) -> Void)
}

struct YouTubeLinkWrapper {
    
    let linkExtractor = YoutubeDirectLinkExtractor()
}

extension YouTubeLinkWrapper: YouTubeLinkWrapperProtocol {
    
    func getLink(from videoId: String, completion: @escaping (String?, Error?) -> Void) {
        let fullLink = Constaints.YoutubeConstaint.videoUrl.rawValue + videoId
        self.linkExtractor.extractInfo(for: .urlString(fullLink), success: { (info) in
            completion(info.highestQualityPlayableLink, nil)
        }) { (error) in
            completion(nil, error)
        }
    }
}
