import Nimble
import NSpry
import Quick
import UIKit

@testable import NFoundationExtraTestHelpers
@testable import NUIKit
@testable import NUIKitExtraTestHelpers
@testable import NUIKitTestHelpers

final class TextViewStylePropertySpec: QuickSpec {
    override func spec() {
        describe("TextViewStyleProperty") {
            var view: UITextView!
            var style: ViewStyle<TextViewStyleProperty>!

            beforeEach {
                view = .init()
                style = [
                    .textColor(.red),
                    .textFont(.systemFont(ofSize: 11)),
                    .tintColor(.green),
                    .borderWidth(11),
                    .borderColor(.brown),
                    .textContainerInset(.init(top: 10, left: 10, bottom: 10, right: 10)),
                    .linkTextAttributes(.white)
                ]
                style.apply(to: view)
            }

            it("should be applied to view") {
                expect(style).to(beAppliedTo(view))
            }

            it("should be applied to view") { @MainActor in
                expect(view.textColor) == .red
                expect(view.font) == .systemFont(ofSize: 11)
                expect(view.tintColor) == .green
                expect(view.layer.borderWidth).to(beCloseTo(11))
                expect(view.layer.borderColor.map(UIColor.init(cgColor:))) == .brown
                expect(view.textContainerInset) == UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
                expect(view.linkTextAttributes).to(equal([NSAttributedString.Key.foregroundColor: UIColor.white], where: { key, a, b in
                    if key == .foregroundColor, let a = a as? UIColor, let b = b as? UIColor {
                        return NUIKitTestHelpers.isEqual(a, b)
                    }
                    return false
                }))
            }

            context("when overriding style") {
                beforeEach {
                    style = [
                        .textColor(.green),
                        .textFont(.systemFont(ofSize: 22)),
                        .tintColor(.yellow),
                        .borderWidth(33),
                        .borderColor(.black),
                        .textContainerInset(.init(top: 30, left: 10, bottom: 10, right: 10)),
                        .linkTextAttributes(.magenta)
                    ]
                    style.apply(to: view)
                }

                it("should be applied to view") {
                    expect(style).to(beAppliedTo(view))
                }

                it("should be applied to view") { @MainActor in
                    expect(view.textColor) == .green
                    expect(view.font) == .systemFont(ofSize: 22)
                    expect(view.tintColor) == .yellow
                    expect(view.layer.borderWidth).to(beCloseTo(33))
                    expect(view.layer.borderColor.map(UIColor.init(cgColor:))) == .black
                    expect(view.textContainerInset) == UIEdgeInsets(top: 30, left: 10, bottom: 10, right: 10)
                    expect(view.linkTextAttributes).to(equal([NSAttributedString.Key.foregroundColor: UIColor.magenta], where: { key, a, b in
                        if key == .foregroundColor, let a = a as? UIColor, let b = b as? UIColor {
                            return NUIKitTestHelpers.isEqual(a, b)
                        }
                        return false
                    }))
                }
            }
        }
    }
}
