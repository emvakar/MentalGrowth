//
//  MGPlaylistItemJSONModel.swift
//  MentalGrowth Test App
//
//  Created by Emil Karimov on 17/04/2020.
//  Copyright © 2020 Emil Karimov. All rights reserved.
//

import Foundation

// MARK: - MGPlaylistItemJSONModel
struct MGPlaylistItemJSONModel: Codable {
    let kind, etag, id: String?
    let snippet: MGPlaylistItemSnippet?
}

// MARK: - Snippet
struct MGPlaylistItemSnippet: Codable {
    let publishedAt, channelID, title: String?
    let snippetDescription: String?
    let thumbnails: MGPlaylistItemThumbnails?
    let channelTitle, playlistID: String?
    let position: Int?
    let resourceID: MGPlaylistItemResourceID?

    enum CodingKeys: String, CodingKey {
        case publishedAt
        case channelID = "channelId"
        case title
        case snippetDescription = "description"
        case thumbnails, channelTitle
        case playlistID = "playlistId"
        case position
        case resourceID = "resourceId"
    }
}

// MARK: - ResourceID
struct MGPlaylistItemResourceID: Codable {
    let kind, videoID: String?

    enum CodingKeys: String, CodingKey {
        case kind
        case videoID = "videoId"
    }
}

// MARK: - Thumbnails
struct MGPlaylistItemThumbnails: Codable {
    let thumbnailsDefault, medium, high, standard: MGPlaylistItemDefault?
    let maxres: MGPlaylistItemDefault?

    enum CodingKeys: String, CodingKey {
        case thumbnailsDefault = "default"
        case medium, high, standard, maxres
    }
}

// MARK: - Default
struct MGPlaylistItemDefault: Codable {
    let url: String?
    let width, height: Int?
}
