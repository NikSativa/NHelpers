import Nimble
import NSpry
import Quick
import UIKit

@testable import NUIKit
@testable import NUIKitExtraTestHelpers
@testable import NUIKitTestHelpers

final class SwitchStylePropertySpec: QuickSpec {
    override func spec() {
        describe("SwitchStyleProperty") {
            var view: UISwitch!
            var style: ViewStyle<SwitchStyleProperty>!

            beforeEach {
                view = .init()
                style = [
                    .tintColor(.red),
                    .thumbTintColor(.green),
                    .onTintColor(.blue)
                ]
                style.apply(to: view)
            }

            it("should be applied to view") {
                expect(style).to(beAppliedTo(view))
            }

            it("should be applied to view") { @MainActor in
                expect(view.tintColor) == .red
                expect(view.thumbTintColor) == .green
                expect(view.onTintColor) == .blue
            }

            context("when overriding style") {
                beforeEach {
                    style = [
                        .tintColor(.white),
                        .thumbTintColor(.gray),
                        .onTintColor(.black)
                    ]
                    style.apply(to: view)
                }

                it("should be applied to view") {
                    expect(style).to(beAppliedTo(view))
                }

                it("should be applied to view") { @MainActor in
                    expect(view.tintColor) == .white
                    expect(view.thumbTintColor) == .gray
                    expect(view.onTintColor) == .black
                }
            }
        }
    }
}
