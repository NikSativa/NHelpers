import Nimble
import NSpry
import Quick

@testable import NTextOperators

final class TextImager_SmartSpec: QuickSpec {
    override func spec() {
        describe("TextImager.Smart") {
            var subject: TextImager!

            beforeEach {
                subject = TextImager.smart {
                    return $0 == "0" ? .testMake(.five) : .testMake(.four)
                }
            }

            it("should add text at the end") {
                expect(subject.image(from: "0")) == .testMake(.five)
                expect(subject.image(from: "1")) == .testMake(.four)
            }

            it("should generate unique id and be equatable") {
                expect(subject) == .smart { _ in return nil }
                expect(subject) != .identity
            }
        }
    }
}
