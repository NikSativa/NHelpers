import Foundation
import Nimble
import NSpry
import Quick

@testable import NXibView
@testable import NXibViewTestHelpers

final class XibViewSpec: QuickSpec {
    override func spec() {
        describe("XibView") {
            context("when configured correctly") {
                var subject: XibViewMain!

                beforeEach { @MainActor in
                    subject = .init()
                }

                it("should not be nil") {
                    expect(subject).toNot(beNil())
                }

                it("should contains subview") { @MainActor in
                    expect(subject.xibView).toNot(beNil())
                    expect(subject.xibView.label).toNot(beNil())
                }
            }

            // #warning("should check UT when throwAssertion will work correctly")
            xcontext("when configured without xib file") {
                it("should throw assertion") {
                    expect { _ = XibViewWrongRoot() }.to(throwAssertion())
                }
            }
        }
    }
}
