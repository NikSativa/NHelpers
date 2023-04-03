// import NSpry
// import UIKit
//
// import NUIKit
// import NUIKitExtraTestHelpers
// import NUIKitTestHelpers
//
// final class ButtonStylePropertySpec: QuickSpec {
//    override func spec() {
//        describe("ButtonStyleProperty") {
//            var view: UIButton!
//            var style: ViewStyle<ButtonStyleProperty>!
//
//            beforeEach {
//                view = UIButton(type: .custom)
//                style = [
//                    .titleColor(.red, .normal),
//                    .backgroundColor(.blue),
//                    .tintColor(.green),
//                    .textFont(.systemFont(ofSize: 11)),
//                    .border(10, .yellow),
//                    .image(.testMake(.three), .normal),
//                    .backgroundImage(.testMake(.four), .normal),
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
//                expect(view.titleColor(for: .normal)) == .red
//                expect(view.backgroundColor) == .blue
//                expect(view.tintColor) == .green
//                expect(view.titleLabel?.font) == .systemFont(ofSize: 11)
//                expect(view.layer.borderColor.map(UIColor.init(cgColor:))) == .yellow
//                expect(view.layer.borderWidth).to(beCloseTo(10))
//                expect(view.image(for: .normal)) == .testMake(.three)
//                expect(view.backgroundImage(for: .normal)) == .testMake(.four)
//                expect(view.layer.cornerRadius).to(beCloseTo(2))
//                expect(view.clipsToBounds).to(beTrue())
//            }
//
//            context("when overriding style") {
//                beforeEach {
//                    style = [
//                        .titleColor(.green, .normal),
//                        .backgroundColor(.yellow),
//                        .tintColor(.white),
//                        .textFont(.systemFont(ofSize: 22)),
//                        .border(11, .brown),
//                        .image(.testMake(.one), .normal),
//                        .backgroundImage(.testMake(.two), .normal),
//                        .cornerRadius(4),
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
//                    expect(view.titleColor(for: .normal)) == .green
//                    expect(view.backgroundColor) == .yellow
//                    expect(view.tintColor) == .white
//                    expect(view.titleLabel?.font) == .systemFont(ofSize: 22)
//                    expect(view.layer.borderColor.map(UIColor.init(cgColor:))) == .brown
//                    expect(view.layer.borderWidth).to(beCloseTo(11))
//                    expect(view.image(for: .normal)) == .testMake(.one)
//                    expect(view.backgroundImage(for: .normal)) == .testMake(.two)
//                    expect(view.layer.cornerRadius).to(beCloseTo(4))
//                    expect(view.clipsToBounds).to(beFalse())
//                }
//            }
//        }
//    }
// }
