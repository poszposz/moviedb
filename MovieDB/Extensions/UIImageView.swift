//
//  UIImageView.swift
//  MovieDB
//

import UIKit

internal extension UIImageView {

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
