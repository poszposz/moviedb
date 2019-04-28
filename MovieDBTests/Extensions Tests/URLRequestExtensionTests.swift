//
//  URLRequestExtensionTests.swift
//  MovieDBTests
//
//  Created by Jan Posz on 28/04/2019.
//  Copyright © 2019 netguru. All rights reserved.
//

import XCTest
@testable import MovieDB

class URLRequestExtensionTests: XCTestCase {

    func testRequestInitialization() {
        let queryItems = [
            URLQueryItem(name: "test1", value: "test1"),
            URLQueryItem(name: "test2", value: "test2")
        ]
        let request = Request<Movie>(method: .GET, path: "/v2/test/api", queryItems: queryItems)
        let urlRequest = URLRequest(request: request, addAuthorization: false)

        XCTAssertEqual(urlRequest.httpMethod, "GET", "Improper method for request.")
        XCTAssertEqual(urlRequest.url?.absoluteString, "https://api.themoviedb.org/v2/test/api?test1=test1&test2=test2", "Improper url string from components.")
    }
}
