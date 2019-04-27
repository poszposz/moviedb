//
//  MovieDataProvider.swift
//  MovieDB
//

import Foundation

internal protocol MovieDataProvider {

    init(networkClient: NetworkClient)

    func obtainMovies(page: Int, sorted: Bool, completion: @escaping (Result<[Movie], NetworkError>) -> ())

    func obtainMovieDetails(movie: Movie, completion: @escaping (Result<MovieDetails, NetworkError>) -> ())
}

internal final class DefaultMovieDataProvider {

    private enum Path {
        case movieList
        case movieDetail(id: Int)

        var urlString: String {
            switch self {
            case .movieList:
                return "/discover/movie"
            case .movieDetail(let id):
                return "/movie/\(id)"
            }
        }
    }

    private let networkClient: NetworkClient

    init(networkClient: NetworkClient) {
        self.networkClient = networkClient
    }

    func obtainMovies(page: Int, sorted: Bool, completion: @escaping (Result<[Movie], NetworkError>) -> ()) {
        var queryItems = [URLQueryItem(name: "page", value: String(page))]
        if sorted {
            queryItems.append(URLQueryItem(name: "sort_by", value: "release_date.desc"))
        }
        let request = Request<[Movie]>(
            method: .GET,
            path: Path.movieList.urlString,
            queryItems: queryItems
        )
        networkClient.perform(request: request, completion: completion)
    }

    func obtainMovieDetails(movie: Movie, completion: @escaping (Result<MovieDetails, NetworkError>) -> ()) {
        let request = Request<MovieDetails>(
            method: .GET,
            path: Path.movieDetail(id: movie.id).urlString,
            queryItems: []
        )
        networkClient.perform(request: request, completion: completion)
    }
}
