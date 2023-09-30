//
//  YoutubeApiVideoDetailsResponse.swift
//  QuitMate
//
//  Created by Саша Василенко on 13.07.2023.
//

import Foundation

// MARK: - YoutubeAPIVideoDetailsResponce
struct YoutubeAPIVideoDetailsResponce: Codable {
    let kind, etag: String
    let items: [YoutubeAPIVideoDetailsResponceItem]
    let pageInfo: YoutubeAPIVideoDetailsResponcePageInfo
}

// MARK: - Item
struct YoutubeAPIVideoDetailsResponceItem: Codable {
    let kind, etag, id: String
    let snippet: YoutubeAPIVideoDetailsResponceSnippet
    let contentDetails: YoutubeAPIVideoDetailsResponceContentDetails
    let statistics: YoutubeAPIVideoDetailsResponceStatistics
    let topicDetails: YoutubeAPIVideoDetailsResponceTopicDetails?
}

// MARK: - ContentDetails
struct YoutubeAPIVideoDetailsResponceContentDetails: Codable {
    let duration, dimension, definition, caption: String
    let licensedContent: Bool
    let contentRating: YoutubeAPIVideoDetailsResponceContentRating
    let projection: String
}

// MARK: - ContentRating
struct YoutubeAPIVideoDetailsResponceContentRating: Codable {
}

// MARK: - Snippet
struct YoutubeAPIVideoDetailsResponceSnippet: Codable {
    let publishedAt: String
    let channelID, title, description: String
    let thumbnails: YoutubeAPIVideoDetailsResponceThumbnails
    let channelTitle: String
    let tags: [String]
    let categoryID, liveBroadcastContent: String
    let localized: YoutubeAPIVideoDetailsResponceLocalized
    let defaultAudioLanguage: String?

    enum CodingKeys: String, CodingKey {
        case publishedAt
        case channelID = "channelId"
        case title, description, thumbnails, channelTitle, tags
        case categoryID = "categoryId"
        case liveBroadcastContent, localized, defaultAudioLanguage
    }
}

// MARK: - Localized
struct YoutubeAPIVideoDetailsResponceLocalized: Codable {
    let title, description: String
}

// MARK: - Thumbnails
struct YoutubeAPIVideoDetailsResponceThumbnails: Codable {
    let thumbnailsDefault, medium, high, standard: YoutubeAPIVideoDetailsResponceDefault

    enum CodingKeys: String, CodingKey {
        case thumbnailsDefault = "default"
        case medium, high, standard
    }
}

// MARK: - Default
struct YoutubeAPIVideoDetailsResponceDefault: Codable {
    let url: String
    let width, height: Int
}

// MARK: - Statistics
struct YoutubeAPIVideoDetailsResponceStatistics: Codable {
    let viewCount, likeCount, favoriteCount: String
}

// MARK: - TopicDetails
struct YoutubeAPIVideoDetailsResponceTopicDetails: Codable {
    let topicCategories: [String]
}

// MARK: - PageInfo
struct YoutubeAPIVideoDetailsResponcePageInfo: Codable {
    let totalResults, resultsPerPage: Int
}
