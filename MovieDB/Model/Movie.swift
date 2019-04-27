//
//  Movie.swift
//  MovieDB
//

import Foundation

internal struct Movie {

    let id: Int

    let title: String

    let overview: String
}

extension Movie: Codable {

    private enum CodinKeys: String, CodingKey {
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
