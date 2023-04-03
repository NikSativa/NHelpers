import Foundation
import NFoundation
import NSpry
import XCTest

final class Optional_FoundationTests: XCTestCase {
    private enum Error: Swift.Error {
        case test
    }

    func test_isNil() {
        var actual: Int?
        XCTAssert(actual.isNil)
        actual = 1
        XCTAssert(!actual.isNil)
    }

    func test_unwrap() {
        var actual: Int?
        XCTAssertThrowsError(try actual.unwrap(Error.test), Error.test)
        actual = 1
        XCTAssertNoThrowError(actual.isNil)
    }
}
