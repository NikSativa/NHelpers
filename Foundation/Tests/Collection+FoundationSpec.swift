import Nimble
import NSpry
import Quick

@testable import NFoundation
@testable import NFoundationTestHelpers

final class Collection_FoundationSpec: QuickSpec {
    override func spec() {
        describe("Collection+Foundation") {
            describe("safe acess to element") {
                var actual: [Int?]!

                context("when array has elements") {
                    beforeEach {
                        let subject: [Int] = Array(1...3)
                        actual = (-1...3).map {
                            subject[safe: $0]
                        }
                    }

                    it("should get correct values") {
                        let expected: [Int?] = [nil, 1, 2, 3, nil]
                        expect(actual) == expected
                    }
                }

                context("when array is empty") {
                    beforeEach {
                        let subject: [Int] = []
                        actual = (-1...3).map {
                            subject[safe: $0]
                        }
                    }

                    it("should get correct values") {
                        let expected: [Int?] = [nil, nil, nil, nil, nil]
                        expect(actual) == expected
                    }
                }
            }

            describe("filterNils()") {
                it("should work correctly") {
                    var actual: [Int?] = []
                    expect(actual.filterNils()) == []
                    actual = [nil, 1, 2, 3, nil]
                    expect(actual.filterNils()) == [1, 2, 3]

                    actual = [nil, nil]
                    expect(actual.filterNils()) == []
                }
            }
        }
    }
}
