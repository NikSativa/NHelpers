import Nimble
import NSpry
import Quick

@testable import NTextOperators

final class TextValidatorSpec: QuickSpec {
    private enum Constant {
        static let sharedName = "TextValidator_shared_behavior"
        static let sharedValidatorsKey = "validatables"
        static let sharedError1Key = "errorText1"
        static let sharedError2Key = "errorText2"
    }

    private struct TestValidator: TextValidatable {
        let uniqueID: String
        let errorText: String? = nil

        init(uniqueID: String) {
            self.uniqueID = uniqueID
        }

        func isValid(string: String) -> Bool {
            return uniqueID != string
        }
    }

    override func spec() {
        describe("TextValidator") {
            var subject: TextValidator!

            describe("equality") {
                beforeEach {
                    subject = .email() + .identity
                }

                it("should be equal") {
                    expect(subject) == .email() + .identity
                    expect(subject) == .identity + .email()
                }

                it("should NOT be equal") {
                    expect(subject) != .identity
                    expect(subject) != .notEmpty() + .identity
                    expect(subject) != .identity + .notEmpty()
                }
            }

            describe("without error texts") {
                beforeEach {
                    subject = .notEmpty()
                }

                it("should be valid") {
                    expect(subject.isTextValid("1")) == .valid
                }

                it("should be invalid without error text") {
                    expect(subject.isTextValid("")) == .invalid
                }
            }

            describe("with error texts") {
                beforeEach {
                    subject = .notEmpty(errorText: "errorText")
                }

                it("should be valid") {
                    expect(subject.isTextValid("1")) == .valid
                }

                it("should be invalid with error text") {
                    expect(subject.isTextValid("")) == .invalidWithErrorText("errorText")
                }
            }

            describe("constructors") {
                var mock1: TextValidatable!
                var mock2: TextValidatable!

                beforeEach {
                    mock1 = TestValidator(uniqueID: "1")
                    mock2 = TestValidator(uniqueID: "2")
                }

                sharedExamples(Constant.sharedName) { contextInfo in
                    var formatables: [TextValidatable]!

                    beforeEach {
                        let contextInfo = contextInfo()
                        formatables = (contextInfo[Constant.sharedValidatorsKey] as? [TextValidatable]) ?? [mock1, mock2]
                    }

                    it("should be equal") {
                        expect(subject) == TextValidator(formatables)
                        expect(subject) == TextValidator(formatables.reversed())
                    }

                    it("should NOT be equal") {
                        expect(subject) != .identity
                        expect(subject) != .notEmpty() + .identity
                        expect(subject) != .identity + .notEmpty()
                    }

                    it("should return image one") {
                        expect(subject.isTextValid("1")) == .invalid
                    }

                    it("should return image two if can") {
                        if formatables.count >= 2 {
                            expect(subject.isTextValid("2")) == .invalid
                        } else {
                            expect(subject.isTextValid("2")) == .valid
                        }
                    }

                    it("should not find correct image and return nil") {
                        expect(subject.isTextValid("12")) == .valid
                    }
                }

                describe("ExpressibleByArrayLiteral") {
                    context("when array of formatables") {
                        beforeEach {
                            subject = .init(arrayLiteral: mock1, mock2)
                        }

                        itBehavesLike(Constant.sharedName)
                    }

                    context("when array of formatables") {
                        beforeEach {
                            subject = [mock1, mock2]
                        }

                        itBehavesLike(Constant.sharedName)
                    }
                }

                describe("array of formatables") {
                    beforeEach {
                        subject = .init([mock1, mock2])
                    }

                    itBehavesLike(Constant.sharedName)
                }

                describe("single formatable") {
                    beforeEach {
                        subject = .init(mock1)
                    }

                    itBehavesLike(Constant.sharedName) {
                        return [Constant.sharedValidatorsKey: [mock1]]
                    }
                }

                describe("array of formaters") {
                    beforeEach {
                        subject = .init(validators: [TextValidator(mock1), TextValidator(mock2)])
                    }

                    itBehavesLike(Constant.sharedName)
                }

                describe("operation 'plus'") {
                    context("when formatter and formatter") {
                        beforeEach {
                            subject = TextValidator(mock1) + TextValidator(mock2)
                        }

                        itBehavesLike(Constant.sharedName)
                    }

                    context("when formatter and formatable") {
                        beforeEach {
                            subject = TextValidator(mock1) + mock2
                        }

                        itBehavesLike(Constant.sharedName)
                    }

                    context("when formatable and formatter") {
                        beforeEach {
                            subject = mock1 + TextValidator(mock2)
                        }

                        itBehavesLike(Constant.sharedName)
                    }

                    context("when formatter and formatable and formatable") {
                        beforeEach {
                            subject = mock1 + TextValidator(mock2) + mock1
                        }

                        itBehavesLike(Constant.sharedName)
                    }

                    context("when formatable and formatable and formatter") {
                        beforeEach {
                            subject = TextValidator(mock2) + mock1 + mock2
                        }

                        itBehavesLike(Constant.sharedName)
                    }

                    context("when formatable and array of formatables") {
                        beforeEach {
                            subject = mock1 + [mock2, mock1]
                        }

                        itBehavesLike(Constant.sharedName)
                    }

                    context("when formatable and formatable and formatter") {
                        beforeEach {
                            subject = TextValidator(mock2) + [mock1, mock2]
                        }

                        itBehavesLike(Constant.sharedName)
                    }
                }
            }
        }
    }
}
