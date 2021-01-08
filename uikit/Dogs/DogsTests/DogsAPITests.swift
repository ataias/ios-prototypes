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

    func test_Endpoint_dogBreedListDoesNoThrow() throws {
        XCTAssertNoThrow(DogAPI.Endpoint.dogBreedList)
    }

    func test_Endpoint_randomImageFromAllDogsCollectionDoesNoThrow() throws {
        XCTAssertNoThrow(DogAPI.Endpoint.randomImageFromAllDogsCollection)
    }

    func test_Endpoint_something() throws {
        XCTAssertNoThrow(DogAPI.Endpoint.randomImageFromBreed(breed: "chichi"))
    }

    func testBreedStringListGenerator() throws {
        let jsonData = """
            {
                "message": {
                    "affenpinscher": [],
                    "australian": [
                        "shepherd"
                    ],
                    "buhund": [
                        "norwegian"
                    ],
                    "bulldog": [
                        "boston",
                        "english",
                        "french"
                    ],
                    "cairn": [],
                },
                "status": "success"
            }
        """.data(using: .utf8)!

        let listBreedsResponse = try JSONDecoder().decode(DogAPI.ListBreedsResponse.self, from: jsonData)
        let breeds = listBreedsResponse.breeds.sorted()
        let expected = [
            "affenpinscher",
            "australian/shepherd",
            "buhund/norwegian",
            "bulldog/boston",
            "bulldog/english",
            "bulldog/french",
            "cairn",
        ]
        XCTAssertEqual(breeds.count, expected.count)
        for (breed, expected) in zip(breeds, expected) {
            XCTAssertEqual(breed, expected)
        }
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
