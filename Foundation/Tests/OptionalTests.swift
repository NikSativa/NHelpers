import Foundation
import NSpry
import XCTest

import NFoundation
import NFoundationTestHelpers

final class OptionalTests: XCTestCase {
    private enum OError: Error {
        case some
    }

    func test_unwrap() {
        var subject: Int?
        XCTAssertThrowsError(try subject.unwrap(OError.some), OError.some)
        subject = 1
        XCTAssertNoThrow(try subject.unwrap(OError.some))
    }

    func test_unwrap_array() {
        var subject: [Int]? = nil
        XCTAssertEqual(subject.unwrapOrEmpty(), [])
        subject = [1]
        XCTAssertEqual(subject.unwrapOrEmpty(), [1])
    }

    func test_unwrap_dictionary() {
        var subject: [Int: Int]? = nil
        XCTAssertEqual(subject.unwrapOrEmpty(), [:])
        subject = [1: 1]
        XCTAssertEqual(subject.unwrapOrEmpty(), [1: 1])
    }
}
