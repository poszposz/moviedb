//
//  Assembly.swift
//  MovieDB
//

import Foundation

internal final class ViewControllerAssembly {

    static let defaultAssembly = ViewControllerAssembly()

    private let dependencyAssembly = DependencyAssembly()

    lazy var moviewListViewController = MovieListViewController(networkClient: dependencyAssembly.networkClient)
}

fileprivate final class DependencyAssembly {

    var networkClient = NetworkClient()
}
