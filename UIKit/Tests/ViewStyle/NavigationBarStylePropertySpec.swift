import Nimble
import NSpry
import Quick
import UIKit

@testable import NFoundationExtraTestHelpers
@testable import NUIKit
@testable import NUIKitExtraTestHelpers
@testable import NUIKitTestHelpers

final class NavigationBarStylePropertySpec: QuickSpec {
    override func spec() {
        describe("NavigationBarStyleProperty") {
            var view: UINavigationBar!
            var style: ViewStyle<NavigationBarStyleProperty>!

            beforeEach {
                view = .init()
                style = [
                    .titleColor(.red),
                    .titleFont(UIFont.systemFont(ofSize: 11)),
                    .backgroundColor(.green),
                    .tintColor(.brown),
                    .barTintColor(.yellow),
                    .isTranslucent(true),
                    .shadowImage(.testMake(.four)),
                    .backgroundImage(.testMake(.three), state: .compact)
                ]

                style.apply(to: view)
            }

            it("should be applied to view") {
                expect(style).to(beAppliedTo(view))
            }

            it("should be applied to view") { @MainActor in
                let expected: [NSAttributedString.Key: Any] = [
                    NSAttributedString.Key.foregroundColor: UIColor.red,
                    NSAttributedString.Key.font: UIFont.systemFont(ofSize: 11)
                ]
                let actual = view.titleTextAttributes
                expect(actual).to(equal(expected, where: { key, a, b in
                    if key == .font, let a = a as? UIFont, let b = b as? UIFont {
                        return a == b
                    } else if key == .foregroundColor, let a = a as? UIColor, let b = b as? UIColor {
                        return NUIKitTestHelpers.isEqual(a, b)
                    }
                    return false
                }))

                expect(view.backgroundColor) == .green
                expect(view.tintColor) == .brown
                expect(view.barTintColor) == .yellow

                expect(view.isTranslucent).to(beTrue())
                expect(view.shadowImage) == .testMake(.four)
                expect(view.backgroundImage(for: .compact)) == .testMake(.three)
            }

            context("when overriding style") {
                beforeEach { @MainActor in
                    view.titleTextAttributes = nil
                    style = [
                        .titleFont(UIFont.systemFont(ofSize: 22)),
                        .titleColor(.gray),
                        .backgroundColor(.red),
                        .tintColor(.yellow),
                        .barTintColor(.brown),
                        .isTranslucent(false),
                        .shadowImage(.testMake(.three)),
                        .backgroundImage(.testMake(.one), state: .compact)
                    ]

                    style.apply(to: view)
                }

                it("should be applied to view") {
                    expect(style).to(beAppliedTo(view))
                }

                it("should be applied to view") { @MainActor in
                    let expected: [NSAttributedString.Key: Any] = [
                        NSAttributedString.Key.foregroundColor: UIColor.gray,
                        NSAttributedString.Key.font: UIFont.systemFont(ofSize: 22)
                    ]
                    let actual = view.titleTextAttributes
                    expect(actual).to(equal(expected, where: { key, a, b in
                        if key == .font, let a = a as? UIFont, let b = b as? UIFont {
                            return a == b
                        } else if key == .foregroundColor, let a = a as? UIColor, let b = b as? UIColor {
                            return NUIKitTestHelpers.isEqual(a, b)
                        }
                        return false
                    }))

                    expect(view.backgroundColor) == .red
                    expect(view.tintColor) == .yellow
                    expect(view.barTintColor) == .brown

                    expect(view.isTranslucent).to(beFalse())
                    expect(view.shadowImage) == .testMake(.three)
                    expect(view.backgroundImage(for: .compact)) == .testMake(.one)
                }
            }
        }
    }
}
