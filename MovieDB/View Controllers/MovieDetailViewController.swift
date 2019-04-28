//
//  MovieDetailViewController.swift
//  MovieDB
//

import UIKit

internal final class MovieDetailViewController: UIViewController {

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView.autolayoutView()
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.alignment = .center
        return stackView
    }()

    private lazy var posterImage: UIImageView = {
        let imageView = UIImageView.autolayoutView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private lazy var titleLabel = UILabel.autolayoutView()

    private lazy var statusLabel = UILabel.autolayoutView()

    private lazy var revenueLabel = UILabel.autolayoutView()

    private lazy var overviewLabel: UILabel = {
        let label = UILabel.autolayoutView()
        label.numberOfLines = 0
        return label
    }()

    private lazy var dollarNumberFormatter: NumberFormatter = {
        let numberFormatter = NumberFormatter()
        numberFormatter.locale = Locale(identifier: "en_US")
        numberFormatter.numberStyle = .currency
        return numberFormatter
    }()

    private let movie: Movie

    private let movieDataProvider: MovieDataProvider

    /// Creates a new instance of MovieDetailViewController. It's a class used to display details of a given movie.
    ///
    /// - Parameters:
    ///   - movie: a movie that details should be downloaded for.
    ///   - movieDataProvider: a class used to download movie details from API.
    init(movie: Movie, movieDataProvider: MovieDataProvider) {
        self.movie = movie
        self.movieDataProvider = movieDataProvider
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable, message: "Not available, use init(movie: _, movieDataProvider: _)")
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = movie.title
        view.backgroundColor = .white
        view.addSubview(stackView)
        stackView.addArrangedSubviews([posterImage, titleLabel, statusLabel, revenueLabel, overviewLabel])
        let constraints = [
            stackView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 50),
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.rightAnchor.constraint(equalTo: view.layoutMarginsGuide.rightAnchor),
            stackView.leftAnchor.constraint(equalTo: view.layoutMarginsGuide.leftAnchor),
            posterImage.heightAnchor.constraint(equalToConstant: 250)
        ]
        NSLayoutConstraint.activate(constraints)
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
        titleLabel.text = movieDetails.title
        statusLabel.text = movieDetails.status
        revenueLabel.text = movieDetails.revenue == 0 ? nil : dollarNumberFormatter.string(from: NSNumber(value: movieDetails.revenue))
        overviewLabel.text = movieDetails.overview
        posterImage.loadResource(path: movieDetails.posterPath)
    }
}
