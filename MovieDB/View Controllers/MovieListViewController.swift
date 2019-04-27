//
//  ViewController.swift
//  MovieDB
//

import UIKit

internal final class MovieListViewController: UIViewController {

    private lazy var tableView: UITableView = {
        let tableView = UITableView.autolayoutView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: UITableViewCell.className)
        tableView.rowHeight = 50
        return tableView
    }()

    private lazy var sortButton = UIBarButtonItem(title: "Sort", style: .plain, target: self, action: #selector(sortTapped))

    private var movies = [Movie]()

    private var currentPage = 1

    private var sorted = false

    private let movieDataProvider: MovieDataProvider

    init(movieDataProvider: MovieDataProvider) {
        self.movieDataProvider = movieDataProvider
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = sortButton
        view.backgroundColor = .white
        view.addSubview(tableView)
        let constraints = [
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
        downloadMovieList(page: currentPage, sorted: sorted)
    }

    private func downloadMovieList(page: Int, sorted: Bool) {
        movieDataProvider.obtainMovies(page: page, sorted: sorted) { [weak self] result in
            switch result {
            case .success(let element):
                self?.movies.append(contentsOf: element.results)
                self?.tableView.reloadData()
            case .failure(let error):
                self?.presentAlert(message: error.humanReadableDescription)
            }
        }
    }

    @objc private func sortTapped() {
        currentPage = 1
        sorted.toggle()
        movies.removeAll()
        tableView.reloadData()
        downloadMovieList(page: currentPage, sorted: sorted)
    }
}

extension MovieListViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UITableViewCell.className, for: indexPath)
        let movie = movies[indexPath.row]
        cell.textLabel?.text = movie.title
        cell.detailTextLabel?.text = movie.overview
        cell.accessoryType = .disclosureIndicator
        return cell
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard indexPath.row == movies.count - 1 else { return }
        currentPage += 1
        downloadMovieList(page: currentPage, sorted: sorted)
    }
}

extension MovieListViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movie = movies[indexPath.row]
        let viewController = ViewControllerAssembly.defaultAssembly.movieDetailsViewController(movie: movie)
        navigationController?.pushViewController(viewController, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
