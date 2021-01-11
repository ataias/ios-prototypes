//
//  StoryBoardBasedViewControllerTests.swift
//  LoadViewControllersTests
//
//  Created by Ataias Pereira Reis on 10/01/21.
//

import XCTest
@testable import LoadViewControllers

class StoryBoardBasedViewControllerTests: XCTestCase {

    func test_loading() {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let sut: StoryBoardBasedViewController = sb.instantiateViewController(identifier: String(describing: StoryBoardBasedViewController.self))
        sut.loadViewIfNeeded()
        XCTAssertNotNil(sut.label)
    }

}
