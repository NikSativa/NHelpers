import Foundation
import Nimble
import Quick

@testable import NFoundation

final class UUIDProviderSpec: QuickSpec {
    override func spec() {
        describe("UUIDProvider") {
            var subject: UUIDProviding!

            var generated: [String]!
            var cached: Set<String>!

            beforeEach {
                subject = UUIDProvider()

                generated = []
                cached = []

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
            }

            it("should generate a new value every time") {
                let set = Set(generated)
                expect(set.count) == 4
            }

            it("should cache the first value") {
                expect(cached.count) == 1
                expect(cached.first) == generated.first
            }
        }
    }
}
