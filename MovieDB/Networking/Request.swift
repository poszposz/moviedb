//
//  Request.swift
//  MovieDB
//

import Foundation

internal enum HttpMethod: String {
    case GET, POST
}

internal struct Request<Response: Codable> {

    let method: HttpMethod

    let path: String

    let queryItems: [URLQueryItem]
}
