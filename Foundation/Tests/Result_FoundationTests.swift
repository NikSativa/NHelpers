import Foundation
import NFoundation
import NSpry
import XCTest

final class Result_FoundationTests: XCTestCase {
    private enum Kind {
        case empty
    }

    private enum Error: Swift.Error {
        case unknown
    }

    func test_value() {
        var subject: Result<Kind, Error>

        subject = .success(.empty)
        XCTAssertEqual(subject.value, .empty)

        subject = .failure(.unknown)
        XCTAssertNil(subject.value)
    }

    func test_error() {
        var subject: Result<Kind, Error>

        subject = .success(.empty)
        XCTAssertNil(subject.error)

        subject = .failure(.unknown)
        XCTAssertEqual(subject.error, .unknown)
    }
}
