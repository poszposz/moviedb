//
//  Page.swift
//  MovieDB
//

import Foundation

internal struct Page<Entity: Decodable> {

    let page: Int

    let results: [Entity]
}

extension Page: Decodable {

    private enum CodingKeys: String, CodingKey {
        case page
        case results
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        page = try container.decode(Int.self, forKey: .page)
        results = try container.decode([Entity].self, forKey: .results)
    }
}
