import Foundation
import NFoundation
import NSpry
import XCTest

final class Collection_FoundationTests: XCTestCase {
    func test_safe_element_access() {
        let subject: ([Int]) -> [Int?] = { arr in
            return (-1...3).map {
                return arr[safe: $0]
            }
        }

        XCTAssertEqual(subject(Array(1...3)), [nil, 1, 2, 3, nil])
        XCTAssertEqual(subject([]), [nil, nil, nil, nil, nil])
        XCTAssertEqual(subject([]), [nil, nil, nil, nil, nil])
    }

    func test_filterNils() {
        var subject: [Int?] = []
        XCTAssertEqual(subject.filterNils(), [])
        subject = [nil, 1, 2, 3, nil]
        XCTAssertEqual(subject.filterNils(), [1, 2, 3])
        subject = [nil, nil]
        XCTAssertEqual(subject.filterNils(), [])
    }
}
