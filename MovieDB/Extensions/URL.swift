//
//  URL.swift
//  MovieDB
//

import Foundation

internal extension URL {

    /// Specifies the types http schemes used to perform requests.
    ///
    /// - http: perform request qithout usage of ssl.
    /// - https: perform request using ssl.
    enum Scheme: String {
        case http, https
    }

    /// A string with a base URL's host to API.
    static let baseURLString = "api.themoviedb.org"

    /// A string with a base URL's host for image downloading.
    static let imageDownloadBaseURLString = "image.tmdb.org"

    /// A base URL for API.
    static var baseURL: URL? {
        var components = URLComponents()
        components.scheme = Scheme.https.rawValue
        components.host = URL.baseURLString
        return components.url
    }

    /// A base URL for image downloads.
    static var imageDownloadBaseURL: URL? {
        var components = URLComponents()
        components.scheme = Scheme.https.rawValue
        components.host = URL.imageDownloadBaseURLString
        return components.url
    }
}
