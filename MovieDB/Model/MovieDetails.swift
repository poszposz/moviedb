//
//  MovieDetail.swift
//  MovieDB
//

import Foundation

internal struct MovieDetails {

    /// API id of the movie.
    let id: Int

    /// A title of the movie.
    let title: String

    /// A short description of the movie.
    let overview: String

    /// A link to the homepage of the movie.
    let homepage: String?

    /// Revenue of the movie in dollars.
    let revenue: Int

    /// Release status of the movie.
    let status: String

    /// Path to the poster image. Should be appended to image base url.
    let posterPath: String?
}

extension MovieDetails: Decodable {

    private enum CodingKeys: String, CodingKey {
        case id
        case title
        case overview
        case homepage
        case revenue
        case status
        case poster_path
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        title = try container.decode(String.self, forKey: .title)
        overview = try container.decode(String.self, forKey: .overview)
        homepage = try container.decodeIfPresent(String.self, forKey: .homepage)
        revenue = try container.decode(Int.self, forKey: .revenue)
        status = try container.decode(String.self, forKey: .status)
        posterPath = try container.decodeIfPresent(String.self, forKey: .poster_path)
    }
}
