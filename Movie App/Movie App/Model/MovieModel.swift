//
//  MovieModel.swift
//  Movie App
//
//  Created by Phincon on 28/10/23.
//

import Foundation

import Foundation

// Define the Date struct for the "dates" key
struct Date: Codable {
    let maximum: String?
    let minimum: String?
}

// Define the Movie struct for the "results" key
struct Movie: Codable {
    let adult: Bool?
    let backdropPath: String?
    let firstAirDate: String?
    let genreIds: [Int]?
    let id: Int?
    let originalLanguage: String?
    let originalTitle: String?
    let originalName: String?
    let name: String?
    let originalCountry: [String]?
    let overview: String?
    let popularity: Double?
    let posterPath: String?
    let releaseDate: String?
    let title: String?
    let video: Bool?
    let voteAverage: Double?
    let voteCount: Int?

    // Use CodingKeys to map JSON keys to model properties
    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case firstAirDate = "first_air_date"
        case genreIds = "genre_ids"
        case id
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case originalName = "original_name"
        case name
        case originalCountry = "origin_country"
        case overview
        case popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title
        case video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}

// Define the Response struct to represent the entire JSON structure
struct MovieResponse: Codable {
    let dates: Date?
    let page: Int?
    let results: [Movie]?
    let totalPages: Int?
    let totalResults: Int?
    
    enum CodingKeys: String, CodingKey {
        case dates
        case page
        case results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}
