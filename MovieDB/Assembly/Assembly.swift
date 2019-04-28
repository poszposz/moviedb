//
//  Assembly.swift
//  MovieDB
//

import Foundation

internal final class ViewControllerAssembly {

    /// A singleton instance of ViewControllerAssembly.
    static let defaultAssembly = ViewControllerAssembly()

    private let dependencyAssembly = DependencyAssembly()

    /// A method used to create a view controller with movie list.
    ///
    /// - Returns: a view controller used for movie list preseentation.
    func moviewListViewController() -> MovieListViewController {
        return MovieListViewController(movieDataProvider: dependencyAssembly.movieDataProvider)
    }

    /// A method used to create a view controller with movie details.
    ///
    /// - Parameter movie: a movie that details should be presented for.
    /// - Returns: a view controller used for movie details preseentation for a given movie.
    func movieDetailsViewController(movie: Movie) -> MovieDetailViewController {
        return MovieDetailViewController(movie: movie, movieDataProvider: dependencyAssembly.movieDataProvider)
    }
}

fileprivate final class DependencyAssembly {

    /// A class used to perform networking calls.
    lazy var networkClient = DefaultNetworkClient()

    /// A class used to download movie details.
    lazy var movieDataProvider = DefaultMovieDataProvider(networkClient: networkClient)
}
