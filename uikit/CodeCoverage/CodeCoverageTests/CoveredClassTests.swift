@testable import CodeCoverage
import XCTest

final class CoveredClassTests: XCTestCase {

    func test_max_with1And2_shouldReturn2() {
        let result = CoveredClass.max(1, 2)
        XCTAssertEqual(result, 2)
    }

    func test_max_with3And2_shouldReturn3() {
        let result = CoveredClass.max(3, 2)
        XCTAssertEqual(result, 3)
    }

    func test_commaSeparated_from3to7_shouldReturn34567SeparatedByCommas() {
        let result = CoveredClass.commaSeparated(from: 3, to: 7)
        XCTAssertEqual(result, "3, 4, 5, 6, 7")
    }

    func test_commaSeparated_from2to2_shouldReturnSomething() {
        let result = CoveredClass.commaSeparated(from: 2, to: 2)
        XCTAssertEqual(result, "2")
    }

    func test_area_withWidth7_shouldBe49() {
        let sut = CoveredClass()
        sut.width = 7
        XCTAssertEqual(sut.area, 49)
    }

//    func test_commaSeparated_from7to3_shouldReturnSomething() {
//        let result = CoveredClass.commaSeparated(from: 7, to: 3)
//        XCTAssertEqual(result, "3, 4, 5, 6, 7")
//    }
    
}
