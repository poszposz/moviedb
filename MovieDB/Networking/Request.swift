//
//  Request.swift
//  MovieDB
//

import Foundation

/// Specifies the moethods used to perform netowrk requests.
///
/// - GET: GET http method.
/// - POST: POST http method.
internal enum HttpMethod: String {
    case GET, POST
}

internal struct Request<Response: Decodable> {

    /// Method that should be used to perform the request.
    let method: HttpMethod

    /// Path to a specified resource in API.
    let path: String

    /// Query items that should be appended to the request's url.
    let queryItems: [URLQueryItem]
}
