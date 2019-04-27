//
//  NSObject.swift
//  MovieDB
//

import Foundation

internal extension NSObject {

    /// Returns class name stripped from module name.
    class var className: String {
        let namespaceClassName = NSStringFromClass(self)
        return namespaceClassName.components(separatedBy: ".").last!
    }

    /// Returns class name stripped from module name.
    var className: String {
        let namespaceClassName = NSStringFromClass(self.classForCoder)
        return namespaceClassName.components(separatedBy: ".").last!
    }
}
