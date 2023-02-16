import Nimble
import NSpry
import Quick

@testable import NTextOperators

final class TextFormatter_EmailSpec: QuickSpec {
    private typealias Constants = TextValidator.Constant

    override func spec() {
        describe("TextFormatter.Email") {
            var subject: TextFormatter!

            beforeEach {
                subject = TextFormatter.email
            }

            it("should do nothing with valid emails") {
                let expected: [String] = Constants.validEmails.map {
                    return subject.formatText($0)
                }

                expect(Constants.validEmails) == expected
            }

            it("should filter additional unrelated characters from email") {
                let expected: [String] = Constants.validEmails.map {
                    let modifiedEmail = "  \n  " + $0.replacingOccurrences(of: "@", with: "!*@@()") + "  \n  "
                    return subject.formatText(modifiedEmail)
                }

                expect(Constants.validEmails) == expected
            }

            it("should do nothing with valid uppercased emails") {
                let expected: [String] = Constants.validEmails.map {
                    let modifiedEmail = $0.uppercased()
                    return subject.formatText(modifiedEmail)
                }

                let actual = Constants.validEmails.map { $0.uppercased() }
                expect(actual) == expected
            }

            it("should do nothing with valid lowercased emails") {
                let expected: [String] = Constants.validEmails.map {
                    let modifiedEmail = $0.lowercased()
                    return subject.formatText(modifiedEmail)
                }

                let actual = Constants.validEmails.map { $0.lowercased() }
                expect(actual) == expected
            }

            it("should generate unique id and be equatable") {
                expect(subject) == .email
                expect(subject) != .identity
            }
        }
    }
}
