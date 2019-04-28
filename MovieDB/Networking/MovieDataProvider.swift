//
//  MovieDataProvider.swift
//  MovieDB
//

import Foundation

internal protocol MovieDataProvider {

    /// Creates a new instance of MovieDataProvider. A clas sused to obtain movie's data.
    ///
    /// - Parameter networkClient: a network client that should be used to download movies.
    init(networkClient: NetworkClient)

    /// Downloads a paginated list of all movies with a specified page number. List can be sorted by movie's release date.
    ///
    /// - Parameters:
    ///   - page: a page that movies should be downloaded for.
    ///   - sorted: specifies if list should be sorted by movie's release date.
    ///   - completion: a completion block executed after network call has finished. Returns a swift Result instance with either a Page with results or an error.
    func obtainMovies(page: Int, sorted: Bool, completion: @escaping (Result<Page<Movie>, NetworkError>) -> ())

    /// Downloads a details of a given movie.
    ///
    /// - Parameters:
    ///   - movie: a movie fro which details should be downloaded.
    ///   - completion: a completion block executed after network call has finished. Returns a swift Result instance with either a Page with results or an error.
    func obtainMovieDetails(movie: Movie, completion: @escaping (Result<MovieDetails, NetworkError>) -> ())
}

/// Default implementation of MovieDataProvider.
internal final class DefaultMovieDataProvider: MovieDataProvider {

    private enum Path {
        case movieList
        case movieDetail(id: Int)

        var urlString: String {
            switch self {
            case .movieList:
                return "/3/discover/movie"
            case .movieDetail(let id):
                return "/3/movie/\(id)"
            }
        }
    }

    private let networkClient: NetworkClient

    init(networkClient: NetworkClient) {
        self.networkClient = networkClient
    }

    func obtainMovies(page: Int, sorted: Bool, completion: @escaping (Result<Page<Movie>, NetworkError>) -> ()) {
        var queryItems = [URLQueryItem(name: "page", value: String(page))]
        if sorted {
            queryItems.append(URLQueryItem(name: "sort_by", value: "release_date.desc"))
        }
        let request = Request<Page<Movie>>(
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
