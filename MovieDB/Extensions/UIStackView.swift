//
//  UIStackView.swift
//  MovieDB
//

import UIKit

internal extension UIStackView {

    /// Convenience method allowing to add an array of arranged subviews.
    /// - Parameter subviews: array of views to be added as arranged subviews.
    func addArrangedSubviews(_ subviews: [UIView]) {
        subviews.forEach { self.addArrangedSubview($0) }
    }
}
