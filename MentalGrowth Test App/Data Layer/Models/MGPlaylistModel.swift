//
//  MGPlaylistModel.swift
//  MentalGrowth Test App
//
//  Created by Emil Karimov on 17/04/2020.
//  Copyright © 2020 Emil Karimov. All rights reserved.
//

import Foundation

struct MGPlaylistModel {
    
    var items: [MGPlaylistItemModel]?
    var nextPageToken: String?
    var prevPageToken: String?
}

extension MGPlaylistModel {
    
    static func convert(apiModel: MGPlaylistJSONModel) -> MGPlaylistModel {
        var model = MGPlaylistModel()
        model.nextPageToken = apiModel.nextPageToken
        model.prevPageToken = apiModel.prevPageToken
        if let items = apiModel.items {
            model.items = MGPlaylistItemModel.convert(from: items)
        }
        return model
    }
}
