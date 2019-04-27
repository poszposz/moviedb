//
//  MovieDetail.swift
//  MovieDB
//

import Foundation

internal struct MovieDetails {

    let id: Int

    let title: String

    let overview: String

    let homepage: String?

    let revenue: Int

    let status: String
}

extension MovieDetails: Codable {

    private enum CodinKeys: String, CodingKey {
        case id
        case title
        case overview
        case homepage
        case revenue
        case status
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        title = try container.decode(String.self, forKey: .title)
        overview = try container.decode(String.self, forKey: .overview)
        homepage = try container.decode(String?.self, forKey: .homepage)
        revenue = try container.decode(Int.self, forKey: .revenue)
        status = try container.decode(String.self, forKey: .status)
    }
}
