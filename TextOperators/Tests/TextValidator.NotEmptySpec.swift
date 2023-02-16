import Nimble
import Quick

@testable import NTextOperators

final class TextValidator_NotEmptySpec: QuickSpec {
    override func spec() {
        describe("TextValidator.NotEmpty") {
            var subject: TextValidator!

            beforeEach {
                subject = TextValidator.notEmpty(errorText: "error")
            }

            it("should run the validaton on a string") {
                expect(subject.isTextValid("")) == .invalidWithErrorText("error")

                expect(subject.isTextValid("some text")) == .valid
            }

            it("should generate unique id and be equatable") {
                expect(subject) == .notEmpty(errorText: "error")
                expect(subject) != .identity
            }
        }
    }
}
