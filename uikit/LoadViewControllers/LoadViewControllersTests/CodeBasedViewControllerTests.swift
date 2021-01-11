//
//  CodeBasedViewControllerTests.swift
//  LoadViewControllersTests
//
//  Created by Ataias Pereira Reis on 10/01/21.
//

import XCTest
@testable import LoadViewControllers

class CodeBasedViewControllerTests: XCTestCase {
    func test_loading() {
        let sut = CodeBasedViewController(data: "DUMMY")
        sut.loadViewIfNeeded()
    }
}
