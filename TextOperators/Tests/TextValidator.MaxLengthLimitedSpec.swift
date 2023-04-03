//
// import NTextOperators
//
// final class TextValidator_MaxLengthLimitedSpec: QuickSpec {
//    override func spec() {
//        describe("TextValidator.MaxLengthLimited") {
//            var subject: TextValidator!
//
//            beforeEach {
//                subject = TextValidator.maxLengthLimited(4)
//            }
//
//            it("should verify the input string") {
//                expect(subject.isTextValid("")) == .valid
//                expect(subject.isTextValid("1")) == .valid
//                expect(subject.isTextValid("12")) == .valid
//                expect(subject.isTextValid("123")) == .valid
//                expect(subject.isTextValid("1234")) == .valid
//
//                expect(subject.isTextValid("12345")) == .invalid
//                expect(subject.isTextValid("123456")) == .invalid
//            }
//
//            it("should generate unique id and be equatable") {
//                expect(subject) == .maxLengthLimited(4)
//                expect(subject) != .identity
//            }
//        }
//    }
// }
