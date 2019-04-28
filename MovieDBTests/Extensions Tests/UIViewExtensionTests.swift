//
//  UIViewExtensionTests.swift
//  MovieDBTests
//
//  Created by Jan Posz on 28/04/2019.
//  Copyright © 2019 netguru. All rights reserved.
//

import XCTest
@testable import MovieDB

class UIViewExtensionTests: XCTestCase {

    func testAutolayoutView() {
        let view = UIView.autolayoutView()
        XCTAssertFalse(view.translatesAutoresizingMaskIntoConstraints, "Translates autoresizing masks into constraints not turned off properly.")
    }
}
