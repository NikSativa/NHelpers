import Nimble
import Quick

@testable import NTextOperators

final class TextValidator_MinLengthLimitedSpec: QuickSpec {
    override func spec() {
        describe("TextValidator.MinLengthLimited") {
            var subject: TextValidator!

            beforeEach {
                subject = TextValidator.minLengthLimited(4)
            }

            it("should verify the input string") {
                expect(subject.isTextValid("")) == .invalid
                expect(subject.isTextValid("1")) == .invalid
                expect(subject.isTextValid("12")) == .invalid
                expect(subject.isTextValid("123")) == .invalid

                expect(subject.isTextValid("1234")) == .valid
                expect(subject.isTextValid("12345")) == .valid
                expect(subject.isTextValid("123456")) == .valid
            }

            it("should generate unique id and be equatable") {
                expect(subject) == .minLengthLimited(4)
                expect(subject) != .identity
            }
        }
    }
}
