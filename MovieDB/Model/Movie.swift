//
//  Movie.swift
//  MovieDB
//

import Foundation

internal struct Movie {

    /// API id of the movie.
    let id: Int

    /// Title of the movie.
    let title: String

    /// Short description of the movie.
    let overview: String
}

extension Movie: Decodable {

    private enum CodingKeys: String, CodingKey {
        case id
        case title
        case overview
        case releaseDate = "release_date"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        title = try container.decode(String.self, forKey: .title)
        overview = try container.decode(String.self, forKey: .overview)
    }
}
