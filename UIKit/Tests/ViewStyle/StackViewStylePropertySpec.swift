// import NSpry
// import UIKit
//
// import NUIKit
// import NUIKitExtraTestHelpers
// import NUIKitTestHelpers
//
// final class StackViewStylePropertySpec: QuickSpec {
//    override func spec() {
//        describe("StackViewStyleProperty") {
//            var view: UIStackView!
//            var style: ViewStyle<StackViewStyleProperty>!
//
//            beforeEach {
//                view = .init()
//                style = [
//                    .margins(.init(top: 1, left: 1, bottom: 1, right: 1)),
//                    .spacing(10),
//                    .axis(.vertical)
//                ]
//
//                style.apply(to: view)
//            }
//
//            it("should be applied to view") {
//                expect(style).to(beAppliedTo(view))
//            }
//
//            it("should be applied to view") { @MainActor in
//                expect(view.layoutMargins) == UIEdgeInsets(top: 1, left: 1, bottom: 1, right: 1)
//                expect(view.isLayoutMarginsRelativeArrangement).to(beTrue())
//
//                expect(view.spacing).to(beCloseTo(10))
//                expect(view.axis) == .vertical
//            }
//
//            context("when overriding style") {
//                beforeEach {
//                    style = [
//                        .margins(.init(top: 2, left: 2, bottom: 2, right: 2)),
//                        .spacing(22),
//                        .axis(.horizontal)
//                    ]
//
//                    style.apply(to: view)
//                }
//
//                it("should be applied to view") {
//                    expect(style).to(beAppliedTo(view))
//                }
//
//                it("should be applied to view") { @MainActor in
//                    expect(view.layoutMargins) == UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2)
//                    expect(view.isLayoutMarginsRelativeArrangement).to(beTrue())
//
//                    expect(view.spacing).to(beCloseTo(22))
//                    expect(view.axis) == .horizontal
//                }
//            }
//        }
//    }
// }
