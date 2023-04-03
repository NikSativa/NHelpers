// import NSpry
// import UIKit
//
// import NUIKit
// import NUIKitTestHelpers
//
// final class UIViewController_UIKitSpec: QuickSpec {
//    override func spec() {
//        describe("UIViewController+UIKit") {
//            var subject: UIViewController!
//
//            beforeEach {
//                subject = .init()
//            }
//
//            describe("clearBackground") {
//                var view: FakeView!
//
//                beforeEach { @MainActor in
//                    view = .init()
//                    subject.view = view
//                    view.stub(.clearBackground).andReturn()
//
//                    subject.clearBackground()
//                }
//
//                it("should call corresponding method at view") {
//                    expect(view).to(haveReceived(.clearBackground))
//                }
//            }
//
//            describe("removeFromParentAndSuperview") {
//                var view: FakeView!
//                var container: UIViewController!
//
//                beforeEach { @MainActor in
//                    view = .init()
//                    subject.view = view
//                    view.stub(.removeFromSuperview).andReturn()
//
//                    container = .init()
//                    container.addChild(subject)
//                }
//
//                it("should configured correctly") { @MainActor in
//                    expect(container.children) == [subject]
//                }
//
//                context("when removing") {
//                    beforeEach {
//                        subject.removeFromParentAndSuperview()
//                    }
//
//                    it("should call corresponding method at view") {
//                        expect(view).to(haveReceived(.removeFromSuperview))
//                    }
//
//                    it("should remove subject from children") { @MainActor in
//                        expect(container.children) == []
//                    }
//                }
//            }
//
//            describe("adding child controller") {
//                var view: FakeView!
//                var container: UIViewController!
//
//                beforeEach {
//                    view = .init()
//                    container = .init()
//                }
//
//                it("should configured correctly") { @MainActor in
//                    expect(subject.children) == []
//                }
//
//                context("when placeholder view is nil") {
//                    beforeEach { @MainActor in
//                        subject.view = view
//                        view.stub(.addAndFillInset).andReturn()
//
//                        subject.add(childController: container, andFill: nil, relatedToSafeArea: false)
//                    }
//
//                    it("should call corresponding method at view") { @MainActor in
//                        expect(view).to(haveReceived(.addAndFillInset, with: container.view, false, UIEdgeInsets.zero))
//                    }
//
//                    it("should remove subject from children") { @MainActor in
//                        expect(subject.children) == [container]
//                    }
//                }
//
//                context("when placeholder view is provided") {
//                    beforeEach {
//                        view.stub(.addAndFillInset).andReturn()
//                        subject.add(childController: container, andFill: view, relatedToSafeArea: false)
//                    }
//
//                    it("should call corresponding method at view") { @MainActor in
//                        expect(view).to(haveReceived(.addAndFillInset, with: container.view, false, UIEdgeInsets.zero))
//                    }
//
//                    it("should remove subject from children") { @MainActor in
//                        expect(subject.children) == [container]
//                    }
//                }
//            }
//        }
//    }
// }
//
// private final class FakeView: UIView, Spryable {
//    enum ClassFunction: String, StringRepresentable {
//        case empty
//    }
//
//    enum Function: String, StringRepresentable {
//        case clearBackground = "clearBackground()"
//        case removeFromSuperview = "removeFromSuperview()"
//        case addAndFillConstant = "addAndFill(_:relatedToSafeArea:constant:)"
//        case addAndFillInset = "addAndFill(_:relatedToSafeArea:insets:)"
//    }
//
//    override func clearBackground() {
//        return spryify()
//    }
//
//    override func removeFromSuperview() {
//        return spryify()
//    }
//
//    override func addAndFill(_ subview: UIView, relatedToSafeArea: Bool = false, constant: CGFloat = 0) {
//        return spryify(arguments: subview, relatedToSafeArea, constant)
//    }
//
//    override func addAndFill(_ subview: UIView, relatedToSafeArea: Bool = false, insets: UIEdgeInsets = .zero) {
//        return spryify(arguments: subview, relatedToSafeArea, insets)
//    }
// }
