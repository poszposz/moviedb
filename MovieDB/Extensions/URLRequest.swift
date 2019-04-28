//
//  URLRequest.swift
//  MovieDB
//

import Foundation
import Keys

internal extension URLRequest {

    /// Dafult timeout for all requests.
    private static let defaultTimeoutInterval: TimeInterval = 30

    /// An API key for the internet movie database. Taken from cocoapods keys.
    private static let apiKey = Keys.MovieDBKeys().movieDatabaseAPIKey

    /// Creates a new instance of URL request for a given Request instance. Adds api key authorization.
    ///
    /// - Parameters:
    ///     - request: a request with all data used to create a URLRequest.
    ///     - addAuthorization: specifies if api key should be added to request.
    init<Response>(request: Request<Response>, addAuthorization: Bool = true) {
        var components = URLComponents()
        components.scheme = URL.Scheme.https.rawValue
        components.host = URL.baseURLString
        components.path = request.path
        components.queryItems = request.queryItems
        if addAuthorization {
            components.queryItems?.append(URLQueryItem(name: "api_key", value: URLRequest.apiKey))
        }
        guard let url = components.url else {
            preconditionFailure("Failed to create url from given components.")
        }
        self.init(url: url, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: URLRequest.defaultTimeoutInterval)
    }
}
