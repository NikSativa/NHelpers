import Nimble
import NSpry
import Quick

@testable import NTextOperators

final class TextFormatterSpec: QuickSpec {
    private enum Constant {
        static let sharedName = "TestFormatter_shared_behavior"
        static let sharedKey = "formatables"
    }

    private struct TestFormatter: TextFormatable {
        let uniqueID: String
        init(uniqueID: String) {
            self.uniqueID = uniqueID
        }

        func formatText(_ string: String) -> String {
            return uniqueID == string ? "uniqueID_" + string : string
        }
    }

    override func spec() {
        describe("TextFormatter") {
            var subject: TextFormatter!

            describe("equality") {
                beforeEach {
                    subject = .stripLeadingSpaces + .numbersOnly
                }

                it("should be equal") {
                    expect(subject) == .stripLeadingSpaces + .numbersOnly
                    expect(subject) == .numbersOnly + .stripLeadingSpaces
                }

                it("should NOT be equal") {
                    expect(subject) != .numbersOnly
                    expect(subject) != .numbersOnly + .identity
                    expect(subject) != .stripLeadingSpaces + .email
                }
            }

            describe("constructors") {
                var mock1: TextFormatable!
                var mock2: TextFormatable!

                beforeEach {
                    mock1 = TestFormatter(uniqueID: "1")
                    mock2 = TestFormatter(uniqueID: "2")
                }

                sharedExamples(Constant.sharedName) { contextInfo in
                    var formatables: [TextFormatable]!

                    beforeEach {
                        let contextInfo = contextInfo()
                        formatables = (contextInfo[Constant.sharedKey] as? [TextFormatable]) ?? [mock1, mock2]
                    }

                    it("should be equal") {
                        expect(subject) == TextFormatter(formatables)
                        expect(subject) == TextFormatter(formatables.reversed())
                    }

                    it("should NOT be equal") {
                        expect(subject) != .numbersOnly
                        expect(subject) != .numbersOnly + .identity
                        expect(subject) != .stripLeadingSpaces + .email
                    }

                    it("should make unique 1 format") {
                        expect(subject.formatText("1")) == "uniqueID_1"
                    }

                    it("should make unique 2 format if can") {
                        expect(subject.formatText("2")) == (formatables.count >= 2 ? "uniqueID_2" : "2")
                    }

                    it("should not make format") {
                        expect(subject.formatText("12")) == "12"
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
                        return [Constant.sharedKey: [mock1]]
                    }
                }

                describe("array of formaters") {
                    beforeEach {
                        subject = .init(formatters: [TextFormatter(mock1), TextFormatter(mock2)])
                    }

                    itBehavesLike(Constant.sharedName)
                }

                describe("operation 'plus'") {
                    context("when formatter and formatter") {
                        beforeEach {
                            subject = TextFormatter(mock1) + TextFormatter(mock2)
                        }

                        itBehavesLike(Constant.sharedName)
                    }

                    context("when formatter and formatable") {
                        beforeEach {
                            subject = TextFormatter(mock1) + mock2
                        }

                        itBehavesLike(Constant.sharedName)
                    }

                    context("when formatable and formatter") {
                        beforeEach {
                            subject = mock1 + TextFormatter(mock2)
                        }

                        itBehavesLike(Constant.sharedName)
                    }

                    context("when formatter and formatable and formatable") {
                        beforeEach {
                            subject = mock1 + TextFormatter(mock2) + mock1
                        }

                        itBehavesLike(Constant.sharedName)
                    }

                    context("when formatable and formatable and formatter") {
                        beforeEach {
                            subject = TextFormatter(mock2) + mock1 + mock2
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
                            subject = TextFormatter(mock2) + [mock1, mock2]
                        }

                        itBehavesLike(Constant.sharedName)
                    }
                }
            }
        }
    }
}
