//
//  UIImageView.swift
//  MovieDB
//

import UIKit

internal extension UIImageView {

    /// Loads the image for a image view with a given resource url appendix string.
    ///
    /// - Parameter path: an appendix that should be added to bas image download url. Obtained from API.
    func loadResource(path: String?) {
        DispatchQueue.global().async { [weak self] in
            guard
                var url = URL.imageDownloadBaseURL,
                let path = path
            else {
                return
            }
            url.appendPathComponent("/t/p/w1280")
            url.appendPathComponent(path)
            do {
                let data = try Data(contentsOf: url)
                let image = UIImage(data: data)
                DispatchQueue.main.async {
                    self?.image = image
                }
            } catch {

            }
        }
    }
}
