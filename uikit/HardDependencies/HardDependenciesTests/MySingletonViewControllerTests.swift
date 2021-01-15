//
//  MySingletonViewControllerTests.swift
//  HardDependenciesTests
//
//  Created by Ataias Pereira Reis on 11/01/21.
//

import XCTest
@testable import HardDependencies

class MySingletonViewControllerTests: XCTestCase {

    override func setUp() {
        super.setUp()
        MySingletonAnalytics.stubbedInstance = MySingletonAnalytics()
    }

    override func tearDown() {
        MySingletonAnalytics.stubbedInstance = nil
        super.tearDown()
    }

    func test_viewDidAppear() {
        let sut = MySingletonViewController()
        sut.loadViewIfNeeded()
        sut.viewDidAppear(false)

        // Normally, assert something
    }
}
