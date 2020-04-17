//
//  MGPlaylistItemModel.swift
//  MentalGrowth Test App
//
//  Created by Emil Karimov on 17/04/2020.
//  Copyright © 2020 Emil Karimov. All rights reserved.
//

import Foundation

struct MGPlaylistItemModel {
    
    var thumbImageUrl: String?
    var descriptionVideo: String?
    var videoID: String?
    var channelTitle: String?
    var videoTitle: String?
    var videoDate: String?
}

extension MGPlaylistItemModel {
    
    private static func convertDate(_ date: String) -> String {
        var _date = ""
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "YYYY-MM-DDThh:mm:ss.sZ"

        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MMM dd,yyyy"

        if let __date = dateFormatterGet.date(from: date) {
            _date = dateFormatterPrint.string(from: __date)
        }
        return _date
    }
}

extension MGPlaylistItemModel {
    
    static func convert(apiModel: MGPlaylistItemJSONModel) -> MGPlaylistItemModel {
        var model = MGPlaylistItemModel()
        model.thumbImageUrl = apiModel.snippet?.thumbnails?.medium?.url
        model.descriptionVideo = apiModel.snippet?.snippetDescription
        model.videoID = apiModel.snippet?.resourceID?.videoID
        model.channelTitle = apiModel.snippet?.channelTitle
        model.videoTitle = apiModel.snippet?.title
        model.videoDate = self.convertDate(apiModel.snippet?.publishedAt ?? "")
        return model
    }
    
    static func convert(from array: [MGPlaylistItemJSONModel]) -> [MGPlaylistItemModel] {
        var model = [MGPlaylistItemModel]()
        for item in array {
            model.append(MGPlaylistItemModel.convert(apiModel: item))
        }
        return model
    }
}

extension MGPlaylistItemModel: Hashable {
    
}
