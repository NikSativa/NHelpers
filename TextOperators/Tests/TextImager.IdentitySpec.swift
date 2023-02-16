import Nimble
import NSpry
import Quick

@testable import NTextOperators

final class TextImager_IdentitySpec: QuickSpec {
    override func spec() {
        describe("TextImager.Identity") {
            var subject: TextImager!

            beforeEach {
                subject = TextImager.identity
            }

            it("should always be nil") {
                expect(subject.image(from: "0")).to(beNil())
                expect(subject.image(from: "1")).to(beNil())
            }

            it("should generate unique id and be equatable") {
                expect(subject) == .identity
                expect(subject) != .single(image: .testMake(.one))
            }
        }
    }
}
