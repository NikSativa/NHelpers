import Foundation
import NOptionalCodable
import NOptionalCodableTestHelpers
import NSpry
import XCTest

final class OptionalDecoderTests: XCTestCase {
    private struct User: Decodable, Equatable, SpryEquatable {
        enum Payment: String, Decodable, Equatable, SpryEquatable {
            case newCard = "NewCard"
            case applePay = "ApplePay"
        }

        let name: String
        let payment: OptionalDecoder<Payment>
    }

    func test_when_decoding_data_is_valid() {
        let subject: User? = subjectAction([
            "name": "bob",
            "payment": "NewCard"
        ])
        let expectedUser = User(name: "bob", payment: .testMake(value: .newCard))
        XCTAssertEqual(subject, expectedUser)
    }

    func test_when_decoding_data_is_invalid() {
        let subject: User? = subjectAction([
            "name": "bob",
            "payment": "GooglePay"
        ])
        let expectedUser = User(name: "bob", payment: .testMake(value: nil))
        XCTAssertEqual(subject, expectedUser)
    }

    func test_when_decoding_data_is_lack() {
        let subject: User? = subjectAction([
            "name": "bob",
            // payment field is required
            "other name of field": "NewCard"
        ])
        XCTAssertNil(subject)
    }
}
