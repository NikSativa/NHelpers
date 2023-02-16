import Nimble
import NSpry
import Quick

@testable import NFoundation
@testable import NFoundationTestHelpers

final class Optional_FoundationSpec: QuickSpec {
    private enum Error: Swift.Error {
        case test
    }

    override func spec() {
        describe("Optional+Foundation") {
            describe("isNil") {
                var actual: Int!

                afterEach {
                    actual = nil
                }

                it("should be nil") {
                    expect(actual).to(beNil())
                    expect(actual.isNil).to(beTrue())
                }

                context("when variable contains value") {
                    beforeEach {
                        actual = 1
                    }

                    it("should NOT be nil") {
                        expect(actual) == 1
                        expect(actual.isNil).to(beFalse())
                    }
                }
            }

            describe("unwrap") {
                var actual: Int!

                afterEach {
                    actual = nil
                }

                it("should throw error") {
                    expect(actual).to(beNil())
                    expect({ try actual.unwrap(Error.test) }).to(throwError(Error.test))
                }

                context("when variable contains value") {
                    beforeEach {
                        actual = 1
                    }

                    it("should unwrap without error throwing") {
                        expect(actual) == 1
                        expect({ try actual.unwrap(Error.test) }).toNot(throwError())
                    }
                }
            }
        }
    }
}
