//
//  NSObjectExtensionTests.swift
//  MovieDBTests
//
//  Created by Jan Posz on 28/04/2019.
//  Copyright © 2019 netguru. All rights reserved.
//

import XCTest
@testable import MovieDB

class NSObjectExtensionTests: XCTestCase {

    func testInstanceClassName() {
        let testView = UIView()
        XCTAssertEqual(testView.className, "UIView", "Improper instance class name for UIView")
        let testTableViewCell = UITableViewCell()
        XCTAssertEqual(testTableViewCell.className, "UITableViewCell", "Improper instance class name for UITableViewCell")
        let testObject = NSObject()
        XCTAssertEqual(testObject.className, "NSObject", "Improper instance class name for NSObject")
    }

    func testStaticClassName() {
        XCTAssertEqual(UIView.className, "UIView", "Improper instance class name for UIView")
        XCTAssertEqual(UITableViewCell.className, "UITableViewCell", "Improper instance class name for UIView")
        XCTAssertEqual(NSObject.className, "NSObject", "Improper instance class name for NSObject")
    }
}
