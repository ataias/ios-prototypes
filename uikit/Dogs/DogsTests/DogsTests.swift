//
//  DogsTests.swift
//  DogsTests
//
//  Created by Ataias Pereira Reis on 01/01/21.
//

import XCTest
@testable import Dogs

class DogsTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testURLDoesNotThrow() throws {
        for endpoint in DogAPI.Endpoint.allCases {
            XCTAssertNoThrow(endpoint.url)
        }
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
