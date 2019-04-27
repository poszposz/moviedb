//
//  URL.swift
//  MovieDB
//

import Foundation

internal extension URL {

    enum Scheme: String {
        case http, https
    }

    static let baseURLString = "api.themoviedb.org"

    static var baseURL: URL? {
        var components = URLComponents()
        components.scheme = Scheme.https.rawValue
        components.host = URL.baseURLString
        return components.url
    }
}
