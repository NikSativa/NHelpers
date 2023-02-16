import Foundation
import Nimble
import NSpry

@testable import NFoundationTestHelpers
@testable import NTextOperators

// MARK: - TextValidator + SpryEquatable

extension TextValidator: SpryEquatable {
    static func testMake() -> TextValidator {
        return .identity
    }
}

// MARK: - TextValidator + TestOutputStringConvertible

extension TextValidator: TestOutputStringConvertible {
    public var testDescription: String {
        let propertyReflector = PropertyReflector(self)
        let formatters: [TextFormatable] = propertyReflector.property(named: "validators") ?? []
        return "TextValidator: " + formatters.compactMap { $0.uniqueID.components(separatedBy: ".").last }.joined(separator: ", ")
    }
}

// MARK: - TextValidator.Constant

extension TextValidator {
    enum Constant {
        static let validEmails: [String] = [
            "j@b.com",
            "email@example.com",
            "firstname.lastname@example.com",
            "email@subdomain.example.com",
            "firstname+lastname@example.com",
            "1234567890@example.com",
            "email@example-one.com",
            "_______@example.com",
            "email@example.co.jp",
            "firstname-lastname@example.com",
            "lynda@lynda.tv",
            "mel@mel.rocks",
            "dontbuy@adomainthatendsin.io",
            "email@example.biz",
            "email@example.name",
            "email@example.museum",
            "tom@riddle1.com",
            "tom@1riddle.com",
            "1tom1@riddle.com"
        ]

        static let invalidEmails: [String] = [
            "plainaddress",
            "#@%^%#$@#$@#.com",
            "@example.com",
            "Joe Smith <email@example.com>",
            "email.example.com",
            "email@example@example.com",
            ".email@example.com",
            "email.@example.com",
            "email..email@example.com",
            "あいうえお@example.com",
            "email@example.com (Joe Smith)",
            "email@example",
            "email@-example.com",
            "email@111.222.333.44444",
            "Abc..123@example.com",
            "email@example..com",
            "email@example-.com",
            "email@.com",
            "email@.",
            "email@",
            "tom@@1riddle.com"
        ]
    }
}
