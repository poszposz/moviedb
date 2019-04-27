//
//  NetworkClient.swift
//  MovieDB
//

import Foundation

internal final class NetworkClient {

    private let urlSession = URLSession(configuration: URLSessionConfiguration.default)

    internal func perform<Response>(request: Request<Response>, completion: @escaping (Result<Response, NetworkError>) -> ()) where Response: Codable {
        let request = URLRequest(request: request)
        urlSession.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(Result.failure(NetworkError.systemError(error: error)))
                return
            }
            guard let httpResponse = response as? HTTPURLResponse, let data = data else {
                return
            }
            if let responseError = NetworkError(code: httpResponse.statusCode) {
                completion(Result.failure(responseError))
                return
            }
            do {
                let responseData = try JSONDecoder().decode(Response.self, from: data)
                completion(Result.success(responseData))
            } catch let error {
                completion(Result.failure(NetworkError.improperResponse(error: error)))
            }
        }
    }
}
