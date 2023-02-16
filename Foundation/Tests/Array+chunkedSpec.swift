import Nimble
import NSpry
import Quick

@testable import NFoundation
@testable import NFoundationTestHelpers

final class Array_chunkedSpec: QuickSpec {
    override func spec() {
        describe("Array+chunked") {
            context("when is empty") {
                var actual: [[Int]]!

                beforeEach {
                    actual = [].chunked(into: 2)
                }

                it("should be an empty") {
                    let expected: [[Int]] = []
                    expect(actual) == expected
                }
            }

            context("when contains 1 element") {
                var actual: [[Int]]!

                beforeEach {
                    actual = [0].chunked(into: 2)
                }

                it("should be an empty") {
                    let expected = [[0]]
                    expect(actual) == expected
                }
            }

            context("when contains 2 elements") {
                var actual: [[Int]]!

                beforeEach {
                    actual = [0, 1].chunked(into: 2)
                }

                it("should be an empty") {
                    let expected: [[Int]] = [[0, 1]]
                    expect(actual) == expected
                }
            }

            context("when contains 3 elements") {
                var actual: [[Int]]!

                beforeEach {
                    actual = [0, 1, 2].chunked(into: 2)
                }

                it("should be an empty") {
                    let expected: [[Int]] = [
                        [0, 1],
                        [2]
                    ]
                    expect(actual) == expected
                }
            }

            context("when contains 9 elements") {
                var actual: [[Int]]!

                beforeEach {
                    actual = [0, 1, 2, 3, 4, 5, 6, 7, 8].chunked(into: 2)
                }

                it("should be an empty") {
                    let expected: [[Int]] = [
                        [0, 1],
                        [2, 3],
                        [4, 5],
                        [6, 7],
                        [8]
                    ]
                    expect(actual) == expected
                }
            }

            context("when contains 10 element") {
                var actual: [[Int]]!

                beforeEach {
                    actual = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9].chunked(into: 2)
                }

                it("should be an empty") {
                    let expected: [[Int]] = [
                        [0, 1],
                        [2, 3],
                        [4, 5],
                        [6, 7],
                        [8, 9]
                    ]
                    expect(actual) == expected
                }
            }
        }
    }
}
