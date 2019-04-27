//
//  MovieDataProvider.swift
//  MovieDB
//

import Foundation

internal protocol MovieDataProvider {

    init(networkClient: NetworkClient)

    func obtainMovies(completion: Result<[Movie], NetworkError>)

    func obtainMovieDetails(completion: Result<MovieDetails, NetworkError>)
}

internal final class DefaultMovieDataProvider {

    private enum Path {
        case movieList, movieDetail

        var urlString: String {
            switch self {
            case .movieList:
                return ""
            case .movieDetail:
                return ""
            }
        }
    }

    private let networkClient: NetworkClient

    init(networkClient: NetworkClient) {
        self.networkClient = networkClient
    }

    func obtainMovies(completion: Result<[Movie], NetworkError>) {
        let request = Request<[Movie]>(
            method: .GET,
            path: Path.movieList.urlString,
            queryItems: []
        )
        networkClient.perform(request: request) { (result) in

        }
    }

    func obtainMovieDetails(completion: Result<MovieDetails, NetworkError>) {
        let request = Request<MovieDetails>(
            method: .GET,
            path: Path.movieDetail.urlString,
            queryItems: []
        )
        networkClient.perform(request: request) { (result) in

        }
    }
}
