import Nimble
import NSpry
import Quick

@testable import NTextOperators

final class TextFormatter_SmartSpec: QuickSpec {
    override func spec() {
        describe("TextFormatter.Smart") {
            var subject: TextFormatter!

            beforeEach {
                subject = TextFormatter.smart {
                    return $0 == "0" ? $0 + "_end" : "start_" + $0
                }
            }

            it("should format a text correctly") {
                expect(subject.formatText("0")) == "0_end"
                expect(subject.formatText("1")) == "start_1"
            }

            it("should generate unique id and be equatable") {
                expect(subject) == .smart { $0 }
                expect(subject) != .identity
            }
        }
    }
}
