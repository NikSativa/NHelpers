//
// import NTextOperators
//
// final class TextValidator_SmartSpec: QuickSpec {
//    private typealias Constants = TextValidator.Constant
//
//    override func spec() {
//        describe("TextValidator.Smart") {
//            var subject: TextValidator!
//
//            beforeEach {
//                subject = TextValidator.email()
//            }
//
//            for email in Constants.invalidEmails {
//                it("should validate '\(email)' as invalid") {
//                    expect(subject.isTextValid(email)).to(equal(.invalid), description: email)
//                }
//
//                let uppercasedEmail = email.uppercased()
//                it("should validate uppercased '\(uppercasedEmail)' as invalid") {
//                    expect(subject.isTextValid(uppercasedEmail)).to(equal(.invalid), description: email)
//                }
//
//                let lowercasedEmail = email.lowercased()
//                it("should validate lowercased '\(lowercasedEmail)' as invalid") {
//                    expect(subject.isTextValid(lowercasedEmail)).to(equal(.invalid), description: email)
//                }
//            }
//
//            for email in Constants.validEmails {
//                it("should validate '\(email)' as valid") {
//                    expect(subject.isTextValid(email)) == .valid
//                }
//
//                let uppercasedEmail = email.uppercased()
//                it("should validate uppercased '\(uppercasedEmail)' as valid") {
//                    expect(subject.isTextValid(uppercasedEmail)) == .valid
//                }
//
//                let lowercasedEmail = email.lowercased()
//                it("should validate lowercased '\(lowercasedEmail)' as valid") {
//                    expect(subject.isTextValid(lowercasedEmail)) == .valid
//                }
//            }
//
//            it("should generate unique id and be equatable") {
//                expect(subject) == .email()
//                expect(subject) != .identity
//            }
//        }
//    }
// }
