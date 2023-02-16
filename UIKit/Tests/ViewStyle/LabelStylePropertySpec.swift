import Nimble
import NSpry
import Quick
import UIKit

@testable import NUIKit
@testable import NUIKitExtraTestHelpers
@testable import NUIKitTestHelpers

final class LabelStylePropertySpec: QuickSpec {
    override func spec() {
        describe("LabelStyleProperty") {
            var view: UILabel!
            var style: ViewStyle<LabelStyleProperty>!

            beforeEach {
                view = .init()
                style = [
                    .textColor(.red),
                    .backgroundColor(.green),
                    .textFont(.systemFont(ofSize: 11)),
                    .textAlignment(.center),
                    .numberOfLines(1)
                ]

                style.apply(to: view)
            }

            it("should be applied to view") {
                expect(style).to(beAppliedTo(view))
            }

            it("should be applied to view") { @MainActor in
                expect(view.textColor) == .red
                expect(view.backgroundColor) == .green
                expect(view.font) == .systemFont(ofSize: 11)
                expect(view.textAlignment) == .center
                expect(view.numberOfLines) == 1
            }

            context("when overriding style") {
                beforeEach {
                    style = [
                        .textColor(.blue),
                        .backgroundColor(.yellow),
                        .textFont(.systemFont(ofSize: 22)),
                        .textAlignment(.left),
                        .numberOfLines(11)
                    ]

                    style.apply(to: view)
                }

                it("should be applied to view") {
                    expect(style).to(beAppliedTo(view))
                }

                it("should be applied to view") { @MainActor in
                    expect(view.textColor) == .blue
                    expect(view.backgroundColor) == .yellow
                    expect(view.font) == .systemFont(ofSize: 22)
                    expect(view.textAlignment) == .left
                    expect(view.numberOfLines) == 11
                }
            }
        }
    }
}
