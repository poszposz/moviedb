//
//  Assembly.swift
//  MovieDB
//

import Foundation

internal final class ViewControllerAssembly {

    static let defaultAssembly = ViewControllerAssembly()

    private let dependencyAssembly = DependencyAssembly()

    func moviewListViewController() -> MovieListViewController {
        return MovieListViewController(movieDataProvider: dependencyAssembly.movieDataProvider)
    }

    func movieDetailsViewController(movie: Movie) -> MovieDetailViewController {
        return MovieDetailViewController(movie: movie, movieDataProvider: dependencyAssembly.movieDataProvider)
    }
}

fileprivate final class DependencyAssembly {

    lazy var networkClient = NetworkClient()

    lazy var movieDataProvider = DefaultMovieDataProvider(networkClient: networkClient)
}
