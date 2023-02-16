import Foundation
import Nimble
import NSpry
import Quick

@testable import NOptionalCodable
@testable import NOptionalCodableTestHelpers

final class OptionalEncoderSpec: QuickSpec {
    struct Order: Encodable {
        let url: OptionalEncoder<String>
    }

    override func spec() {
        describe("OptionalEncoder") {
            context("when encoding valid url") {
                let order = Order(url: .testMake(value: "google.com"))

                it("should encode as string") {
                    let data = try! JSONEncoder().encode(order)

                    let string = String(data: data, encoding: .utf8)
                    expect(string) == "{\"url\":\"google.com\"}"
                }
            }

            context("when encoding nil") {
                let order = Order(url: .testMake(value: nil))

                it("should encode as null") {
                    let data = try! JSONEncoder().encode(order)

                    let string = String(data: data, encoding: .utf8)
                    expect(string) == "{\"url\":null}"
                }
            }
        }
    }
}
