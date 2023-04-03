import Foundation
import NFoundation
import NSpry
import XCTest

final class Array_chunkedTests: XCTestCase {
    func test_chunked() {
        var actual: [[Int]]
        actual = [].chunked(into: 2)
        XCTAssertEqual(actual, [])

        actual = [0].chunked(into: 2)
        XCTAssertEqual(actual, [[0]])

        actual = [0, 1].chunked(into: 2)
        XCTAssertEqual(actual, [[0, 1]])

        actual = [0, 1, 2].chunked(into: 2)
        XCTAssertEqual(actual, [[0, 1], [2]])

        actual = [0, 1, 2, 3].chunked(into: 2)
        XCTAssertEqual(actual, [[0, 1], [2, 3]])

        actual = [0, 1, 2, 3, 4].chunked(into: 2)
        XCTAssertEqual(actual, [[0, 1], [2, 3], [4]])

        actual = [0, 1, 2, 3, 4, 5, 6, 7, 8].chunked(into: 2)
        XCTAssertEqual(actual, [[0, 1], [2, 3], [4, 5], [6, 7], [8]])

        actual = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9].chunked(into: 2)
        XCTAssertEqual(actual, [[0, 1], [2, 3], [4, 5], [6, 7], [8, 9]])
    }
}
