//
//  MyClassTests.swift
//  UnitTestingBasicsTests
//
//  Created by Ataias Pereira Reis on 07/01/21.
//

import XCTest
@testable import UnitTestingBasics
// @testable makes internal definitions available for testing; if your definitions are public, you don't need it

class MyClassTests: XCTestCase {
    private var sut: MyClass!

    override func setUp() {
        super.setUp()
        sut = MyClass()
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func test_methodOne() {
        sut.methodOne()
//        XCTFail("Failed, yo")
    }

    func test_methodTwo() {
//        let sut = MyClass()
        sut.methodTwo()
    }

    func test_methodTwoAgain() {
        sut.methodTwo()
    }
}

