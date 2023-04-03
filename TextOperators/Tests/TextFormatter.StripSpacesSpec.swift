// import NSpry
//
// import NTextOperators
//
// final class TextFormatter_StripSpacesSpec: QuickSpec {
//    override func spec() {
//        describe("TextFormatter.StripSpaces") {
//            var subject: TextFormatter!
//
//            beforeEach {
//                subject = TextFormatter.stripLeadingAndTrailingSpaces
//            }
//
//            it("should strip all leading and trailing whitepace") {
//                expect(subject.formatText("    absd 456    ")) == "absd 456"
//            }
//
//            it("should generate unique id and be equatable") {
//                expect(subject) == .stripLeadingAndTrailingSpaces
//                expect(subject) != .identity
//            }
//        }
//    }
// }
