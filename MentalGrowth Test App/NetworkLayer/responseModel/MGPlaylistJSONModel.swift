//
//  MGPlaylistJSONModel.swift
//  MentalGrowth Test App
//
//  Created by Emil Karimov on 17/04/2020.
//  Copyright © 2020 Emil Karimov. All rights reserved.
//

import Foundation

// MARK: - MGPlaylistJSONModel
struct MGPlaylistJSONModel: Codable {
    let kind, etag, nextPageToken, prevPageToken: String?
    let pageInfo: MGPlaylistPageInfo?
    let items: [MGPlaylistItemJSONModel]?
}

// MARK: - PageInfo
struct MGPlaylistPageInfo: Codable {
    let totalResults, resultsPerPage: Int?
}
