//
//  MovieDetailViewController.swift
//  MovieDB
//

import UIKit

internal final class MovieDetailViewController: UIViewController {

    private let movie: Movie
    private let movieDataProvider: MovieDataProvider

    init(movie: Movie, movieDataProvider: MovieDataProvider) {
        self.movie = movie
        self.movieDataProvider = movieDataProvider
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = movie.title
        view.backgroundColor = .white
        downloadMovieDetails()
    }

    private func downloadMovieDetails() {
        movieDataProvider.obtainMovieDetails(movie: movie) { [weak self] result in
            switch result {
            case .success(let details):
                self?.realoadWith(movieDetails: details)
            case .failure(let error):
                self?.presentAlert(message: error.humanReadableDescription)
            }
        }
    }

    private func realoadWith(movieDetails: MovieDetails) {

    }
}
