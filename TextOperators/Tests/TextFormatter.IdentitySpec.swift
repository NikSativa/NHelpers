import Foundation
import Nimble
import NSpry
import Quick

@testable import NTextOperators

final class TextFormatter_IdentitySpec: QuickSpec {
    override func spec() {
        describe("TextFormatter.Identity") {
            var subject: TextFormatter!

            beforeEach {
                subject = TextFormatter.identity
            }

            it("should do nothing") {
                let text = " a 1 b 2 c 3 ! "
                expect(subject.formatText(text)) == text
            }

            it("should do nothing with random string") {
                let text = UUID().uuidString
                expect(subject.formatText(text)) == text
            }

            it("should generate unique id and be equatable") {
                expect(subject) == .identity
                expect(subject) != .email
            }
        }
    }
}
