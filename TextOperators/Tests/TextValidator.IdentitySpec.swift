// import Foundation
//
// import NTextOperators
//
// final class TextValidator_IdentitySpec: QuickSpec {
//    override func spec() {
//        describe("TextValidator.Identity") {
//            var subject: TextValidator!
//
//            beforeEach {
//                subject = TextValidator.identity
//            }
//
//            it("should verify the input string") {
//                expect(subject.isTextValid("")) == .valid
//                expect(subject.isTextValid("sdfsd 🤓")) == .valid
//                expect(subject.isTextValid(UUID().uuidString)) == .valid
//            }
//
//            it("should generate unique id and be equatable") {
//                expect(subject) == .identity
//                expect(subject) != .email()
//            }
//        }
//    }
// }
