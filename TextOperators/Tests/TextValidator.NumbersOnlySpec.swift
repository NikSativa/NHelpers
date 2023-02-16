import Nimble
import Quick

@testable import NTextOperators

final class TextValidator_NumbersOnlySpec: QuickSpec {
    override func spec() {
        describe("TextValidator.NumbersOnly") {
            var subject: TextValidator!

            beforeEach {
                subject = TextValidator.numbersOnly()
            }

            it("should verify the input string") {
                expect(subject.isTextValid("")) == .valid
                expect(subject.isTextValid("123")) == .valid

                expect(subject.isTextValid("abc123")) == .invalid
                expect(subject.isTextValid("123abc")) == .invalid
            }

            it("should generate unique id and be equatable") {
                expect(subject) == .numbersOnly()
                expect(subject) != .identity
            }
        }
    }
}
