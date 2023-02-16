import Nimble
import Quick

@testable import NTextOperators

final class TextValidator_IncludesLowerAndUppercaseSpec: QuickSpec {
    override func spec() {
        describe("TextValidator.IncludesLowerAndUppercase") {
            var subject: TextValidator!

            beforeEach {
                subject = TextValidator.includesLowerAndUppercase()
            }

            it("should verify the input string") {
                expect(subject.isTextValid("")) == .invalid
                expect(subject.isTextValid("abc")) == .invalid
                expect(subject.isTextValid("ABC")) == .invalid

                expect(subject.isTextValid("aB")) == .valid
                expect(subject.isTextValid("aBc")) == .valid
                expect(subject.isTextValid("AbC")) == .valid
                expect(subject.isTextValid("A123abc")) == .valid
            }

            it("should generate unique id and be equatable") {
                expect(subject) == .includesLowerAndUppercase()
                expect(subject) != .identity
            }
        }
    }
}
