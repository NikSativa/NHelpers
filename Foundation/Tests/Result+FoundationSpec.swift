import Nimble
import NSpry
import Quick

@testable import NFoundation
@testable import NFoundationTestHelpers

final class Result_FoundationSpec: QuickSpec {
    private enum Kind {
        case empty
    }

    private enum Error: Swift.Error {
        case unknown
    }

    override func spec() {
        describe("Result+Foundation") {
            var subject: Result<Kind, Error>!

            describe("value") {
                context("when result is success") {
                    beforeEach {
                        subject = .success(.empty)
                    }

                    it("should return value") {
                        expect(subject.value) == .empty
                    }
                }

                context("when result is failure") {
                    beforeEach {
                        subject = .failure(.unknown)
                    }

                    it("should return nil") {
                        expect(subject.value).to(beNil())
                    }
                }
            }

            describe("error") {
                context("when result is success") {
                    beforeEach {
                        subject = .success(.empty)
                    }

                    it("should return value") {
                        expect(subject.error).to(beNil())
                    }
                }

                context("when result is failure") {
                    beforeEach {
                        subject = .failure(.unknown)
                    }

                    it("should return nil") {
                        expect(subject.error) == .unknown
                    }
                }
            }
        }
    }
}
