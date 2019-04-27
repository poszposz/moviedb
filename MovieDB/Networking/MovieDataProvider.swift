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

    private let networkClient: NetworkClient

    init(networkClient: NetworkClient) {
        self.networkClient = networkClient
    }

    func obtainMovies(completion: Result<[Movie], NetworkError>) {

    }

    func obtainMovieDetails(completion: Result<MovieDetails, NetworkError>) {

    }
}
