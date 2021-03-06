//
//  NetworkClient.swift
//  MovieDB
//

import Foundation

internal protocol NetworkClient {

    /// Performs a given Request to the API.
    ///
    /// - Parameters:
    ///   - request: a request that should be performed.
    ///   - completion: a completion block executed after network call has finished. Returns a swift Result instance with either a Page with results or an error.
    func perform<Response>(request: Request<Response>, completion: @escaping (Result<Response, NetworkError>) -> ()) where Response: Decodable
}

internal final class DefaultNetworkClient: NetworkClient {

    private let urlSession = URLSession(configuration: URLSessionConfiguration.default)

    internal func perform<Response>(request: Request<Response>, completion: @escaping (Result<Response, NetworkError>) -> ()) where Response: Decodable {
        let request = URLRequest(request: request)
        urlSession.dataTask(with: request) { [weak self] (data, response, error) in
            if let error = error {
                self?.dispatch(result: Result.failure(NetworkError.systemError(error: error)), on: completion)
                return
            }
            guard let httpResponse = response as? HTTPURLResponse, let data = data else {
                return
            }
            if let responseError = NetworkError(code: httpResponse.statusCode) {
                self?.dispatch(result: Result.failure(responseError), on: completion)
                return
            }
            do {
                let responseData = try JSONDecoder().decode(Response.self, from: data)
                self?.dispatch(result: Result.success(responseData), on: completion)
            } catch let error {
                self?.dispatch(result: Result.failure(NetworkError.improperResponse(error: error)), on: completion)
            }
        }.resume()
    }

    private func dispatch<Response>(result: Result<Response, NetworkError>, on closure: @escaping (Result<Response, NetworkError>) -> ()) {
        DispatchQueue.main.async {
            closure(result)
        }
    }
}
