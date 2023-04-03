// import NSpry
// import UIKit
//
// import NFoundationExtraTestHelpers
// import NUIKit
// import NUIKitExtraTestHelpers
// import NUIKitTestHelpers
//
// final class BarItemStylePropertySpec: QuickSpec {
//    override func spec() {
//        describe("BarItemStyleProperty") {
//            var subject: ViewStyle<BarItemStyleProperty>!
//            var view: UIBarButtonItem!
//
//            beforeEach { @MainActor in
//                subject = [
//                    .textColor(.red, .normal),
//                    .textColor(.green, .highlighted),
//                    .textColor(.blue, .disabled),
//                    .textFont(UIFont.systemFont(ofSize: 10), .normal),
//                    .textFont(UIFont.systemFont(ofSize: 15), .highlighted),
//                    .textFont(UIFont.systemFont(ofSize: 20), .disabled)
//                ]
//
//                view = .init()
//                view.title = "some text"
//
//                subject.apply(to: view)
//            }
//
//            it("should style the view") {
//                let expected: [NSAttributedString.Key: Any] = [
//                    NSAttributedString.Key.foregroundColor: UIColor.red,
//                    NSAttributedString.Key.font: UIFont.systemFont(ofSize: 10)
//                ]
//                let actual = view.titleTextAttributes(for: .normal)
//                expect(actual).to(equal(expected, where: { key, a, b in
//                    if key == .font, let a = a as? UIFont, let b = b as? UIFont {
//                        return a == b
//                    } else if key == .foregroundColor, let a = a as? UIColor, let b = b as? UIColor {
//                        return NUIKitTestHelpers.isEqual(a, b)
//                    }
//                    return false
//                }))
//            }
//        }
//    }
// }
