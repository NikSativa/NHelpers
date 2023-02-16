import Foundation
import Nimble
import NSpry
import Quick

@testable import NOptionalCodable
@testable import NOptionalCodableTestHelpers

final class OptionalDecoderSpec: QuickSpec {
    private func subjectAction<T: Decodable>(_ json: [String: Any]) -> T? {
        (try? JSONSerialization.data(withJSONObject: json)).flatMap { data in
            return try? JSONDecoder().decode(T.self, from: data)
        }
    }

    override func spec() {
        describe("OptionalDecoder") {
            struct User: Decodable, Equatable, SpryEquatable {
                enum Payment: String, Decodable, Equatable, SpryEquatable {
                    case newCard = "NewCard"
                    case applePay = "ApplePay"
                }

                let name: String
                let payment: OptionalDecoder<Payment>
            }

            describe("decoding") {
                context("when decoding data is valid") {
                    var subject: User?

                    beforeEach {
                        subject = self.subjectAction(["name": "bob", "payment": "NewCard"])
                    }

                    it("should init a user with 'New Card' payment") {
                        let expectedUser = User(name: "bob", payment: .testMake(value: .newCard))
                        expect(subject) == expectedUser
                    }
                }

                context("when payment data is invalid") {
                    var subject: User?

                    beforeEach {
                        subject = self.subjectAction(["name": "bob", "payment": "GooglePay"])
                    }

                    it("should init a user with absent payment field") {
                        let expectedUser = User(name: "bob", payment: .testMake(value: nil))
                        expect(subject) == expectedUser
                    }
                }

                context("when decoding data is invalid") {
                    var subject: User?

                    beforeEach {
                        subject = self.subjectAction(["name": "bob", "other name of field": "NewCard"]) // payment field is required
                    }

                    it("should not init a user") {
                        expect(subject).to(beNil())
                    }
                }
            }
        }
    }
}
