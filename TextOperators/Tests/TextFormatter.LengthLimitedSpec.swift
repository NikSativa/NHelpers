// import NSpry
//
// import NTextOperators
//
// final class TextFormatter_LengthLimitedSpec: QuickSpec {
//    override func spec() {
//        describe("TextFormatter.LengthLimited") {
//            var subject: TextFormatter!
//
//            beforeEach {
//                subject = TextFormatter.lengthLimited(4)
//            }
//
//            it("should limit text length") {
//                expect(subject.formatText("")) == ""
//                expect(subject.formatText("1")) == "1"
//                expect(subject.formatText("12")) == "12"
//                expect(subject.formatText("123")) == "123"
//                expect(subject.formatText("1234")) == "1234"
//                expect(subject.formatText("12345")) == "1234"
//            }
//
//            it("should generate unique id and be equatable") {
//                expect(subject) == .lengthLimited(4)
//                expect(subject) != .lengthLimited(5)
//            }
//        }
//    }
// }
