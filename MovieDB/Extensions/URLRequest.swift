//
//  URLRequest.swift
//  MovieDB
//

import Foundation
import Keys

internal extension URLRequest {

    /// Dafult timeout for all requests.
    private static let defaultTimeoutInterval: TimeInterval = 30

    private enum Scheme: String {
        case http, https
    }

    private static let baseURL = "api.themoviedb.org"
    private static let apiKey = Keys.MovieDBKeys().movieDatabaseAPIKey

    init<Response>(request: Request<Response>) {
        var components = URLComponents()
        components.scheme = Scheme.https.rawValue
        components.host = URLRequest.baseURL
        components.path = request.path
        components.queryItems = request.queryItems
        components.queryItems?.append(URLQueryItem(name: "api_key", value: URLRequest.apiKey))
        guard let url = components.url else {
            preconditionFailure("Failed to create url from given components.")
        }
        self.init(url: url, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: URLRequest.defaultTimeoutInterval)
    }
}
