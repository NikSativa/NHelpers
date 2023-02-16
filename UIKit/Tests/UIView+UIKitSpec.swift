import Nimble
import NSpry
import NSpry_Nimble
import Quick
import UIKit

@testable import NUIKit
@testable import NUIKitTestHelpers

final class UIView_UIKitSpec: QuickSpec {
    override func spec() {
        describe("UIView+UIKit") {
            var view: UIView!

            beforeEach {
                view = .init()
            }

            describe("translatesAutoresizingMaskIntoConstraints") {
                context("when enabling") {
                    beforeEach { @MainActor in
                        view.translatesAutoresizingMaskIntoConstraints = true
                        view.enableConstraints()
                    }

                    it("should disable autoresizing mask") { @MainActor in
                        expect(view.translatesAutoresizingMaskIntoConstraints).to(beFalse())
                    }
                }

                context("when disabling") {
                    beforeEach { @MainActor in
                        view.translatesAutoresizingMaskIntoConstraints = false
                        view.disableConstraints()
                    }

                    it("should enable autoresizing mask") { @MainActor in
                        expect(view.translatesAutoresizingMaskIntoConstraints).to(beTrue())
                    }
                }
            }

            describe("clearBackground") {
                beforeEach { @MainActor in
                    view.backgroundColor = .red
                    view.clearBackground()
                }

                it("should clear background color") { @MainActor in
                    expect(view.backgroundColor) == UIColor.clear
                }
            }

            describe("setMaskByRounding") {
                beforeEach {
                    view.setMaskByRounding(corners: .allCorners, cornerRadii: CGSize(width: 8, height: 8))
                }

                it("should clear background color") { @MainActor in
                    expect(view.layer.mask).to(beAKindOf(CAShapeLayer.self))
                    expect((view.layer.mask as? CAShapeLayer)?.path).toNot(beNil())
                }
            }

            describe("removeAllSubviews") {
                beforeEach {
                    (0..<3).forEach { _ in
                        view.addSubview(UIView())
                    }
                }

                it("should configured correctly") { @MainActor in
                    expect(view.subviews.count) == 3
                }

                context("when removing") {
                    beforeEach {
                        view.removeAllSubviews()
                    }

                    it("should remove all subviews") { @MainActor in
                        expect(view.subviews).to(beEmpty())
                    }
                }
            }

            describe("addAndFill") {
                var subview: FakeView!

                beforeEach {
                    subview = .init()
                    subview.stub(.enableConstraints).andReturn()
                }

                context("when related to safe area") {
                    beforeEach {
                        subview.stub(.safeAreaLayoutGuide).andReturn()
                        view.addAndFill(subview, relatedToSafeArea: true)
                    }

                    it("should configured correctly") { @MainActor in
                        expect(view.subviews.count) == 1
                        expect(view.constraints.count) == 8
                        expect(subview.constraints.count) == 0
                    }

                    it("should use safeAreaLayoutGuide") {
                        expect(subview).toNot(haveReceived(.safeAreaLayoutGuide))
                    }

                    it("should enable constraints") {
                        expect(subview).to(haveReceived(.enableConstraints))
                    }
                }

                context("when not related to safe area") {
                    beforeEach {
                        view.addAndFill(subview, relatedToSafeArea: false)
                    }

                    it("should configured correctly") { @MainActor in
                        expect(view.subviews.count) == 1
                        expect(view.constraints.count) == 4
                        expect(subview.constraints).to(beEmpty())
                    }

                    it("should enable constraints") {
                        expect(subview).to(haveReceived(.enableConstraints))
                    }
                }
            }

            describe("takeScreenshot") {
                var image: UIImage!

                beforeEach { @MainActor in
                    let view = UIImageView(image: UIImage.colored(UIColor.red, size: .init(width: 10, height: 10)))
                    image = view.takeScreenshot()
                }

                it("should generate image") {
                    expect(image).toNot(beNil())
                    expect(image.size) == CGSize(width: 10, height: 10)
                }
            }
        }
    }
}

private final class FakeView: UIView, Spryable {
    enum ClassFunction: String, StringRepresentable {
        case empty
    }

    enum Function: String, StringRepresentable {
        case safeAreaLayoutGuide
        case enableConstraints = "enableConstraints()"
        case disableConstraints = "disableConstraints()"
    }

    @available(iOS 11.0, *)
    override var safeAreaLayoutGuide: UILayoutGuide {
        return spryify(fallbackValue: super.safeAreaLayoutGuide)
    }

    override func disableConstraints() {
        return spryify()
    }

    override func enableConstraints() {
        return spryify()
    }
}
