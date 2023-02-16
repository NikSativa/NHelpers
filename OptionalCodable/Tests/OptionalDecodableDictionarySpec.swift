import Foundation
import Nimble
import NSpry
import Quick

@testable import NOptionalCodable
@testable import NOptionalCodableTestHelpers

final class OptionalDecodableDictionarySpec: QuickSpec {
    private func subjectAction<T: Decodable>(_ json: [String: Any]) -> T? {
        (try? JSONSerialization.data(withJSONObject: json)).flatMap { data in
            return try? JSONDecoder().decode(T.self, from: data)
        }
    }

    override func spec() {
        describe("OptionalDecodableDictionary") {
            struct User: Decodable, Equatable, SpryEquatable {
                enum Payment: String, Decodable, Equatable, SpryEquatable {
                    case newCard = "NewCard"
                    case applePay = "ApplePay"
                }

                let name: String
                let payments: OptionalDecodableDictionary<String, Payment>
            }

            context("when decoding invalid data") {
                var subject: User?

                beforeEach {
                    subject = self.subjectAction(["name": "bob", "payments": ["NewCard", "ApplePay"]])
                }

                it("should init a user with two payments") {
                    let expectedUser = User(name: "bob", payments: .testMake())
                    expect(subject) == expectedUser
                }
            }

            context("when decoding valid data") {
                var subject: User?

                beforeEach {
                    subject = self.subjectAction(["name": "bob", "payments": ["1": "NewCard", "2": "ApplePay"]])
                }

                it("should init a user with two payments") {
                    let expectedUser = User(name: "bob", payments: .testMake(values: ["1": .newCard, "2": .applePay]))
                    expect(subject) == expectedUser
                }
            }

            context("when decoding data where one of the payments is invalid") {
                var subject: User?

                beforeEach {
                    subject = self.subjectAction(["name": "bob", "payments": ["1": "NewCard", "2": "GooglePay"]])
                }

                it("should init a user with one payment") {
                    let expectedUser = User(name: "bob", payments: .testMake(values: ["1": .newCard]))
                    expect(subject) == expectedUser
                }
            }

            context("when decoding data where payments are invalid") {
                var subject: User?

                beforeEach {
                    subject = self.subjectAction(["name": "bob", "payments": ["1": "PayPal", "2": "GooglePay"]])
                }

                it("should init a user without payments") {
                    let expectedUser = User(name: "bob", payments: .testMake(values: [:]))
                    expect(subject) == expectedUser
                }
            }

            context("when decoding data where no payments field") {
                var subject: User?

                beforeEach {
                    subject = self.subjectAction(["name": "bob", "other name of field": ["1": "PayPal", "2": "GooglePay", "3": "NewCard"]]) // payment field is required
                }

                it("should not init a user") {
                    expect(subject).to(beNil())
                }
            }
        }
    }
}
