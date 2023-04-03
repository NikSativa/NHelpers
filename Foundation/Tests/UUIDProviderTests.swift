import Foundation
import NFoundation
import NSpry
import XCTest

final class UUIDProviderTests: XCTestCase {
    func test_uuid() {
        let subject: UUIDProvider = .init()

        var generated: [String] = []
        var cached: Set<String> = []

        generated.append(subject.generateNew())
        cached.insert(subject.cached)
        cached.insert(subject.cached)
        generated.append(subject.generateNew())
        cached.insert(subject.cached)
        cached.insert(subject.cached)
        generated.append(subject.generateNew())
        cached.insert(subject.cached)
        cached.insert(subject.cached)
        generated.append(subject.generateNew())

        XCTAssertEqual(generated.count, 4)
        XCTAssertEqual(cached.count, 1)
        XCTAssertEqual(cached.first, generated.first)

        XCTAssertNotEqual(subject.generateNew(andUpdateCache: false), generated.first)
        XCTAssertNotEqual(subject.generateNew(andUpdateCache: false), cached.first)
    }
}
