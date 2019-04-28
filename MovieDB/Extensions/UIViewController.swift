//
//  UIViewController.swift
//  MovieDB
//

import UIKit

internal extension UIViewController {

    /// Presents a UIAlertController on screen with a given message and single ok button to dismiss it.
    ///
    /// - Parameter message: a message that should be presented within the alert.
    func presentAlert(message: String) {
        let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
}
