import Nimble
import NSpry
import Quick
import UIKit

@testable import NUIKit
@testable import NUIKitExtraTestHelpers
@testable import NUIKitTestHelpers

final class ViewStyleSpec: QuickSpec {
    private enum Constant {
        static let softBlackStyle: ViewStyle<LabelStyleProperty> = [.textColor(.black)]

        static let brandonRegular15SoftBlack: LabelStyleProperty = .textFont(.systemFont(ofSize: 10))
        static let brandonRegular15SoftBlackStyle: ViewStyle<LabelStyleProperty> = [brandonRegular15SoftBlack]
    }

    override func spec() {
        describe("ViewStyle") {
            var labelBackgroundColor: ViewStyle<LabelStyleProperty>!
            var label: UILabel!

            beforeEach {
                labelBackgroundColor = ViewStyle(.backgroundColor(.black))
                label = UILabel()
            }

            it("should equals") {
                let expected = Constant.softBlackStyle + Constant.brandonRegular15SoftBlackStyle
                let actual = Constant.softBlackStyle + Constant.brandonRegular15SoftBlack
                expect(expected == actual).to(beTrue())
            }

            context("apply a single style") {
                beforeEach {
                    Constant.softBlackStyle.apply(to: label)
                }

                it("should apply the soft black style") {
                    expect(Constant.softBlackStyle).to(beAppliedTo(label))
                }
            }

            context("compose styles via `plus<ViewStyle>`") {
                var viewStyle: ViewStyle<LabelStyleProperty>!

                beforeEach {
                    viewStyle = Constant.softBlackStyle + Constant.brandonRegular15SoftBlackStyle
                    viewStyle.apply(to: label)
                }

                it("should have applied the label style tag") {
                    expect(viewStyle).to(beAppliedTo(label))
                }
            }

            context("compose styles via `plus<T>`") {
                var viewStyle: ViewStyle<LabelStyleProperty>!

                beforeEach {
                    viewStyle = Constant.softBlackStyle + Constant.brandonRegular15SoftBlack
                    viewStyle.apply(to: label)
                }

                it("should have applied the label style tag") {
                    expect(viewStyle).to(beAppliedTo(label))
                }
            }

            context("compose styles via reversed `plus<T>`") {
                var viewStyle: ViewStyle<LabelStyleProperty>!

                beforeEach {
                    viewStyle = Constant.brandonRegular15SoftBlack + Constant.softBlackStyle
                    viewStyle.apply(to: label)
                }

                it("should have applied the label style tag") {
                    expect(viewStyle).to(beAppliedTo(label))
                }
            }

            context("compose styles via `plus-equal<ViewStyle>`") {
                var viewStyle: ViewStyle<LabelStyleProperty>!

                beforeEach {
                    viewStyle = Constant.softBlackStyle
                    viewStyle += Constant.brandonRegular15SoftBlackStyle
                    viewStyle.apply(to: label)
                }

                it("should have applied the label style tag") {
                    expect(viewStyle).to(beAppliedTo(label))
                }
            }

            context("compose styles via `plus-equal<T>`") {
                var viewStyle: ViewStyle<LabelStyleProperty>!

                beforeEach {
                    viewStyle = Constant.softBlackStyle
                    viewStyle += Constant.brandonRegular15SoftBlack
                    viewStyle.apply(to: label)
                }

                it("should have applied the label style tag") {
                    expect(viewStyle).to(beAppliedTo(label))
                }
            }

            context("when we apply the background color") {
                beforeEach {
                    labelBackgroundColor.apply(to: label)
                }

                it("should set the background color") { @MainActor in
                    expect(label.backgroundColor) == .black
                }
            }
        }
    }
}
