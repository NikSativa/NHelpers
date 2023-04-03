// import NSpry
// import UIKit
//
// import NUIKit
// import NUIKitExtraTestHelpers
// import NUIKitTestHelpers
//
// final class ImageViewStylePropertySpec: QuickSpec {
//    override func spec() {
//        describe("ImageViewStyleProperty") {
//            var view: UIImageView!
//            var style: ViewStyle<ImageViewStyleProperty>!
//
//            beforeEach {
//                view = .init()
//                style = [
//                    .tintColor(.red),
//                    .borderColor(.green),
//                    .borderWidth(1),
//                    .contentMode(.bottom),
//                    .cornerRadius(2),
//                    .clipsToBounds(true)
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
//                expect(view.tintColor) == .red
//                expect(view.layer.borderColor.map(UIColor.init(cgColor:))) == .green
//                expect(view.layer.borderWidth).to(beCloseTo(1))
//                expect(view.contentMode) == .bottom
//                expect(view.layer.cornerRadius).to(beCloseTo(2))
//                expect(view.clipsToBounds).to(beTrue())
//            }
//
//            context("when overriding style") {
//                beforeEach {
//                    style = [
//                        .tintColor(.green),
//                        .borderColor(.brown),
//                        .borderWidth(2),
//                        .contentMode(.center),
//                        .cornerRadius(3),
//                        .clipsToBounds(false)
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
//                    expect(view.tintColor) == .green
//                    expect(view.layer.borderColor.map(UIColor.init(cgColor:))) == .brown
//                    expect(view.layer.borderWidth).to(beCloseTo(2))
//                    expect(view.contentMode) == .center
//                    expect(view.layer.cornerRadius).to(beCloseTo(3))
//                    expect(view.clipsToBounds).to(beFalse())
//                }
//            }
//        }
//    }
// }
