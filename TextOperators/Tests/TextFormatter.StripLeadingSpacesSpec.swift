// import NSpry
//
// import NTextOperators
//
// final class TextFormatter_StripLeadingSpacesSpec: QuickSpec {
//    override func spec() {
//        describe("TextFormatter.StripLeadingSpaces") {
//            var subject: TextFormatter!
//
//            beforeEach {
//                subject = TextFormatter.stripLeadingSpaces
//            }
//
//            it("should strip all leading and trailing whitepace") {
//                expect(subject.formatText("    absd 456    ")) == "absd 456    "
//            }
//
//            it("should generate unique id and be equatable") {
//                expect(subject) == .stripLeadingSpaces
//                expect(subject) != .identity
//            }
//        }
//    }
// }
