import Foundation
import NOptionalCodable
import NOptionalCodableTestHelpers
import NSpry
import XCTest

final class OptionalDecodableCollectionTests: XCTestCase {
    private struct User: Decodable, Equatable, SpryEquatable {
        enum Payment: String, Decodable, Equatable, SpryEquatable {
            case newCard = "NewCard"
            case applePay = "ApplePay"
        }

        let name: String
        let payments: OptionalDecodableCollection<Payment>
    }

    func test_when_decoding_invalid_data() {
        let subject: User? = subjectAction([
            "name": "bob",
            "payments": [
                "1": "NewCard",
                "2": "ApplePay"
            ]
        ])
        let expectedUser = User(name: "bob", payments: .testMake())
        XCTAssertEqual(subject, expectedUser)
    }

    func test_when_decoding_valid_data() {
        let subject: User? = subjectAction([
            "name": "bob",
            "payments": [
                "NewCard",
                "ApplePay"
            ]
        ])
        let expectedUser = User(name: "bob", payments: .testMake(values: [.newCard, .applePay]))
        XCTAssertEqual(subject, expectedUser)
    }

    func test_when_decoding_data_where_one_of_the_payments_is_invalid() {
        let subject: User? = subjectAction([
            "name": "bob",
            "payments": [
                "NewCard", "GooglePay"
            ]
        ])
        let expectedUser = User(name: "bob", payments: .testMake(values: [.newCard]))
        XCTAssertEqual(subject, expectedUser)
    }

    func test_when_decoding_data_where_payments_are_invalid() {
        let subject: User? = subjectAction([
            "name": "bob",
            "payments": [
                "PayPal", "GooglePay"
            ]
        ])
        let expectedUser = User(name: "bob", payments: .testMake(values: []))
        XCTAssertEqual(subject, expectedUser)
    }

    func test_when_decoding_data_where_no_payments_field() {
        let subject: User? = subjectAction([
            // payment field is required
            "name": "bob",
            "other name of field": [
                "PayPal",
                "GooglePay",
                "NewCard"
            ]
        ])
        XCTAssertNil(subject)
    }
}
