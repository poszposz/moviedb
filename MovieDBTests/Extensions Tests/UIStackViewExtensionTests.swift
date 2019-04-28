//
//  UIStackViewExtensionTests.swift
//  MovieDBTests
//
//  Created by Jan Posz on 28/04/2019.
//  Copyright © 2019 netguru. All rights reserved.
//

import XCTest
@testable import MovieDB

class UIStackViewExtensionTests: XCTestCase {

    func testArrangedSubviews() {
        let subview1 = UIImageView()
        let subview2 = UIView()
        let subview3 = UILabel()

        let stackView = UIStackView()
        stackView.addArrangedSubviews([subview1, subview2, subview3])

        XCTAssertEqual(stackView.arrangedSubviews.count, 3, "Wrong amount of arranged subviews")
        XCTAssertEqual(stackView.arrangedSubviews[0], subview1, "Wrong amount of arranged subviews")
        XCTAssertEqual(stackView.arrangedSubviews[2], subview3, "Wrong amount of arranged subviews")
    }
}
