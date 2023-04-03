// import NSpry
// import UIKit
//
// import NUIKit
// import NUIKitExtraTestHelpers
// import NUIKitTestHelpers
//
// final class TextFieldStylePropertySpec: QuickSpec {
//    override func spec() {
//        describe("TextFieldStyleProperty") {
//            var view: UITextField!
//            var style: ViewStyle<TextFieldStyleProperty>!
//
//            beforeEach {
//                view = .init()
//                style = [
//                    .backgroundColor(.yellow),
//                    .textColor(.red),
//                    .textFont(.systemFont(ofSize: 11)),
//                    .borderStyle(.line)
//                ]
//                style.apply(to: view)
//            }
//
//            it("should be applied to view") {
//                expect(style).to(beAppliedTo(view))
//            }
//
//            it("should be applied to view") { @MainActor in
//                expect(view.backgroundColor) == .yellow
//                expect(view.textColor) == .red
//                expect(view.font) == .systemFont(ofSize: 11)
//                expect(view.borderStyle) == .line
//            }
//
//            context("when overriding style") {
//                beforeEach {
//                    style = [
//                        .backgroundColor(.white),
//                        .textColor(.black),
//                        .textFont(.systemFont(ofSize: 22)),
//                        .borderStyle(.bezel)
//                    ]
//                    style.apply(to: view)
//                }
//
//                it("should be applied to view") {
//                    expect(style).to(beAppliedTo(view))
//                }
//
//                it("should be applied to view") { @MainActor in
//                    expect(view.backgroundColor) == .white
//                    expect(view.textColor) == .black
//                    expect(view.font) == .systemFont(ofSize: 22)
//                    expect(view.borderStyle) == .bezel
//                    expect(view.isSecureTextEntry).to(beFalse())
//                }
//            }
//        }
//    }
// }
