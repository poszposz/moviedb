//
//  Request.swift
//  MovieDB
//

import Foundation

internal enum HttpMethod: String {
    case GET, POST
}

internal struct Request<Response: Decodable> {

    let method: HttpMethod

    let path: String

    let queryItems: [URLQueryItem]
}
