//
//  UIView.swift
//  MovieDB
//

import UIKit

internal extension UIView {

    /// Creates a new instance of specified view with translatesAutoresizingMaskIntoConstraints set to false.
    class func autolayoutView() -> Self {
        let view = self.init()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
}
