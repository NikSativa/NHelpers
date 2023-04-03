import Foundation
import NOptionalCodable
import NOptionalCodableTestHelpers
import NSpry
import XCTest

final class OptionalDecodableDictionaryTests: XCTestCase {
    private struct User: Decodable, Equatable, SpryEquatable {
        enum Payment: String, Decodable, Equatable, SpryEquatable {
            case newCard = "NewCard"
            case applePay = "ApplePay"
        }

        let name: String
        let payments: OptionalDecodableDictionary<String, Payment>
    }

    func test_when_decoding_invalid_data() {
        let subject: User? = subjectAction([
            "name": "bob",
            "payments": [
                "NewCard", "ApplePay"
            ]
        ])
        let expectedUser = User(name: "bob", payments: .testMake())
        XCTAssertEqual(subject, expectedUser)
    }

    func test_when_decoding_valid_data() {
        let subject: User? = subjectAction([
            "name": "bob",
            "payments": [
                "1": "NewCard",
                "2": "ApplePay"
            ]
        ])
        let expectedUser = User(name: "bob", payments: .testMake(values: ["1": .newCard, "2": .applePay]))
        XCTAssertEqual(subject, expectedUser)
    }

    func test_when_decoding_data_where_one_of_the_payments_is_invalid() {
        let subject: User? = subjectAction([
            "name": "bob",
            "payments": [
                "1": "NewCard",
                "2": "GooglePay"
            ]
        ])
        let expectedUser = User(name: "bob", payments: .testMake(values: ["1": .newCard]))
        XCTAssertEqual(subject, expectedUser)
    }

    func test_when_decoding_data_where_payments_are_invalid() {
        let subject: User? = subjectAction([
            "name": "bob",
            "payments": [
                "1": "PayPal",
                "2": "GooglePay"
            ]
        ])
        let expectedUser = User(name: "bob", payments: .testMake(values: [:]))
        XCTAssertEqual(subject, expectedUser)
    }

    func test_when_decoding_data_where_no_payments_field() {
        let subject: User? = subjectAction([
            "name": "bob",
            // payment field is required
            "other name of field": [
                "1": "PayPal",
                "2": "GooglePay",
                "3": "NewCard"
            ]
        ])
        XCTAssertNil(subject)
    }
}
