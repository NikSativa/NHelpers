import Nimble
import NSpry
import Quick
import UIKit

@testable import NUIKit
@testable import NUIKitExtraTestHelpers
@testable import NUIKitTestHelpers

final class PageControlStylePropertySpec: QuickSpec {
    override func spec() {
        describe("PageControlStyleProperty") {
            var view: UIPageControl!
            var style: ViewStyle<PageControlStyleProperty>!

            beforeEach {
                view = .init()
                style = [
                    .pageIndicatorTintColor(.red),
                    .currentPageIndicatorTintColor(.green)
                ]

                style.apply(to: view)
            }

            it("should be applied to view") {
                expect(style).to(beAppliedTo(view))
            }

            it("should be applied to view") { @MainActor in
                expect(view.pageIndicatorTintColor) == .red
                expect(view.currentPageIndicatorTintColor) == .green
            }

            context("when overriding style") {
                beforeEach {
                    style = [
                        .pageIndicatorTintColor(.brown),
                        .currentPageIndicatorTintColor(.yellow)
                    ]

                    style.apply(to: view)
                }

                it("should be applied to view") {
                    expect(style).to(beAppliedTo(view))
                }

                it("should be applied to view") { @MainActor in
                    expect(view.pageIndicatorTintColor) == .brown
                    expect(view.currentPageIndicatorTintColor) == .yellow
                }
            }
        }
    }
}
