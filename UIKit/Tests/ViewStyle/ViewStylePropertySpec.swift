import Nimble
import NSpry
import Quick
import UIKit

@testable import NUIKit
@testable import NUIKitExtraTestHelpers
@testable import NUIKitTestHelpers

final class ViewStylePropertySpec: QuickSpec {
    override func spec() {
        describe("ViewStyleProperty") {
            var view: UIView!
            var style: ViewStyle<ViewStyleProperty>!

            beforeEach {
                view = .init()
                style = [
                    .backgroundColor(.red),
                    .border(.green, 30),
                    .shadow(radius: 10, opacity: 0.9, offset: .init(width: 11, height: 11), color: .brown),
                    .cornerRadius(20),
                    .clipsToBounds(true),
                    .tintColor(.yellow)
                ]

                style.apply(to: view)
            }

            it("should be applied to view") {
                expect(style).to(beAppliedTo(view))
            }

            it("should be applied to view") { @MainActor in
                expect(view.backgroundColor) == .red

                expect(view.layer.borderColor.map(UIColor.init(cgColor:))) == .green
                expect(view.layer.borderWidth).to(beCloseTo(30))

                expect(view.layer.shadowRadius).to(beCloseTo(10))
                expect(view.layer.shadowOpacity).to(beCloseTo(0.9))
                expect(view.layer.shadowOffset) == CGSize(width: 11, height: 11)
                expect(view.layer.shadowColor.map(UIColor.init(cgColor:))) == .brown

                expect(view.layer.cornerRadius).to(beCloseTo(20))

                expect(view.clipsToBounds).to(beTrue())

                expect(view.tintColor) == .yellow
            }

            context("when overriding style") {
                beforeEach {
                    style = [
                        .backgroundColor(.blue),
                        .border(.magenta, 10),
                        .shadow(radius: 20, opacity: 0.9, offset: .init(width: 11, height: 11), color: .black),
                        .cornerRadius(12),
                        .clipsToBounds(false),
                        .tintColor(.white)
                    ]

                    style.apply(to: view)
                }

                it("should be applied to view") {
                    expect(style).to(beAppliedTo(view))
                }

                it("should be applied to view") { @MainActor in
                    expect(view.backgroundColor) == .blue

                    expect(view.layer.borderColor.map(UIColor.init(cgColor:))) == .magenta
                    expect(view.layer.borderWidth).to(beCloseTo(10))

                    expect(view.layer.shadowRadius).to(beCloseTo(20))
                    expect(view.layer.shadowOpacity).to(beCloseTo(0.9))
                    expect(view.layer.shadowOffset) == CGSize(width: 11, height: 11)
                    expect(view.layer.shadowColor.map(UIColor.init(cgColor:))) == .black

                    expect(view.layer.cornerRadius).to(beCloseTo(12))

                    expect(view.clipsToBounds).to(beFalse())

                    expect(view.tintColor) == .white
                }
            }
        }
    }
}
