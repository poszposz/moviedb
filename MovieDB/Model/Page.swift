//
//  Page.swift
//  MovieDB
//

import Foundation

/// A class used as a generic wrapper to handle paginated requests.
internal struct Page<Entity: Decodable> {

    /// A currently downloaded page.
    let page: Int

    /// An array of generic results associated with a given page.
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
