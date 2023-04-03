// import Foundation
// import NSpry
// import UIKit
//
// import NUIKit
// import NUIKitTestHelpers
//
// final class ModalPresenterSpec: QuickSpec {
//    override func spec() {
//        // MARK: - warning("rewrite test for linear flow")
//
//        xdescribe("ModalPresenter") {
//            var subject: ModalPresenter!
//            var keyWindowProvider: FakeAppWindowProvider!
//            var rootViewController: FakeUIViewController!
//            var window: UIWindow!
//
//            beforeEach { @MainActor in
//                rootViewController = .init()
//                window = .init()
//                window.rootViewController = rootViewController
//
//                keyWindowProvider = .init()
//                keyWindowProvider.stub(.appWindow).andReturn(window)
//
//                subject = ModalPresenter(keyWindowProvider: keyWindowProvider)
//            }
//
//            afterEach { @MainActor in
//                keyWindowProvider.resetCallsAndStubs()
//                rootViewController.resetCallsAndStubs()
//                rootViewController.stub(.dismiss).andReturn()
//                rootViewController.stub(.presentedViewController).andReturn(nil)
//
//                // internal behaviour to dismiss root view controller on destruction of window
//                window.rootViewController = .init()
////                UIApplication.shared.keyWindow?.rootViewController = .init()
//            }
//
//            describe("top level VC") {
//                context("when the root view controller is NOT presenting anything else") {
//                    var modalPresenter: UIViewController!
//
//                    beforeEach {
//                        rootViewController.stub(.presentedViewController).andReturn(nil)
//                        modalPresenter = subject.presenter()
//                    }
//
//                    it("should have the root view controller as the modal presenter") {
//                        expect(modalPresenter).to(be(rootViewController))
//                    }
//                }
//
//                context("when rootViewController's presented view controller is being dismissed") {
//                    var modalPresenter: UIViewController!
//                    var presentedViewController: FakeUIViewController!
//
//                    beforeEach {
//                        presentedViewController = .init()
//                        presentedViewController.stub(.isBeingDismissed).andReturn(true)
//                        presentedViewController.stub(.isMovingFromParent).andReturn(false)
//                        rootViewController.stub(.presentedViewController).andReturn(presentedViewController)
//
//                        modalPresenter = subject.presenter()
//                    }
//
//                    it("modal presenter should be the root view controller and not the preseneted") {
//                        expect(modalPresenter).to(be(rootViewController))
//                        expect(modalPresenter).toNot(be(presentedViewController))
//                    }
//                }
//
//                context("when rootViewController's presented view controller is moving from parent") {
//                    var modalPresenter: UIViewController!
//                    var presentedViewController: FakeUIViewController!
//
//                    beforeEach {
//                        presentedViewController = .init()
//                        presentedViewController.stub(.isBeingDismissed).andReturn(false)
//                        presentedViewController.stub(.isMovingFromParent).andReturn(true)
//                        rootViewController.stub(.presentedViewController).andReturn(presentedViewController)
//
//                        modalPresenter = subject.presenter()
//                    }
//
//                    it("modal presenter should be the root view controller and not the preseneted") {
//                        expect(modalPresenter).to(be(rootViewController))
//                        expect(modalPresenter).toNot(be(presentedViewController))
//                    }
//                }
//
//                context("when the root view controller is presenting 1 other view controller") {
//                    var modalPresenter: UIViewController!
//                    var presentedViewController: FakeUIViewController!
//
//                    beforeEach {
//                        presentedViewController = .init()
//                        presentedViewController.stub(.isBeingDismissed).andReturn(false)
//                        presentedViewController.stub(.isMovingFromParent).andReturn(false)
//                        presentedViewController.stub(.presentedViewController).andReturn(nil)
//                        rootViewController.stub(.presentedViewController).andReturn(presentedViewController)
//
//                        modalPresenter = subject.presenter()
//                    }
//
//                    it("should have the another view controller as the modal presenter") {
//                        expect(modalPresenter).to(be(presentedViewController))
//                    }
//                }
//
//                context("when the root view controller is presenting 5 other view controllers") {
//                    var modalPresenter: UIViewController!
//                    var lastViewController: UIViewController!
//
//                    beforeEach {
//                        lastViewController = .init()
//
//                        var viewController: FakeUIViewController?
//                        for _ in 0..<5 {
//                            let current = FakeUIViewController()
//                            current.stub(.isBeingDismissed).andReturn(false)
//                            current.stub(.isMovingFromParent).andReturn(false)
//                            current.stub(.presentedViewController).andReturn(viewController ?? lastViewController)
//                            viewController = current
//                        }
//
//                        rootViewController.stub(.isBeingDismissed).andReturn(false)
//                        rootViewController.stub(.isMovingFromParent).andReturn(false)
//                        rootViewController.stub(.presentedViewController).andReturn(viewController)
//
//                        modalPresenter = subject.presenter()
//                    }
//
//                    it("should have the fifth view controller as the modal presenter") {
//                        expect(modalPresenter).to(be(lastViewController))
//                    }
//                }
//            }
//
//            describe("presenting VCs") {
//                context("when presenting view controller; when the root view controller is NOT presenting anything else") {
//                    beforeEach {
//                        rootViewController.stub(.presentedViewController).andReturn(nil)
//                        rootViewController.stub(.present).andReturn()
//                    }
//
//                    context("when animated by default") {
//                        var modalViewController: UIViewController!
//
//                        beforeEach {
//                            modalViewController = UIViewController()
//                            subject.lineUp(modalViewController)
//                        }
//
//                        it("should present view controller modally") {
//                            expect(rootViewController).to(haveReceived(.present, with: modalViewController, true, Argument.anything))
//                        }
//                    }
//
//                    context("when animated") {
//                        var modalViewController: UIViewController!
//
//                        beforeEach {
//                            modalViewController = UIViewController()
//                            subject.lineUp(modalViewController, animated: true)
//                        }
//
//                        it("should present view controller modally") {
//                            expect(rootViewController).to(haveReceived(.present, with: modalViewController, true, Argument.anything))
//                        }
//                    }
//
//                    context("when NOT animated") {
//                        var modalViewController: UIViewController!
//
//                        beforeEach {
//                            modalViewController = UIViewController()
//                            subject.lineUp(modalViewController, animated: false)
//                        }
//
//                        it("should present view controller modally") {
//                            expect(rootViewController).to(haveReceived(.present, with: modalViewController, false, Argument.anything))
//                        }
//                    }
//                }
//
//                context("when dismissing view controller; when the root view controller is presenting 1 other view controller") {
//                    var anotherViewController: FakeUIViewController!
//
//                    beforeEach {
//                        anotherViewController = .init()
//
//                        rootViewController.stub(.presentedViewController).andReturn(nil)
//                        rootViewController.stub(.present).andReturn()
//
//                        subject.lineUp(anotherViewController)
//                    }
//
//                    it("should save already presented view controller as modal") {
//                        expect(rootViewController).to(haveReceived(.present, with: anotherViewController, true, Argument.anything))
//                    }
//
//                    it("should not queuing view controller") {
//                        expect(subject.queue).to(beEmpty())
//                    }
//
//                    context("present another view controller") {
//                        var modalViewController: UIViewController!
//
//                        beforeEach {
//                            modalViewController = .init()
//                            rootViewController.resetCallsAndStubs()
//                            rootViewController.stub(.presentedViewController).andReturn(nil)
//                        }
//
//                        context("when animated by default") {
//                            beforeEach {
//                                subject.lineUp(modalViewController)
//                            }
//
//                            it("should add the second view controller to queue") {
//                                expect(subject.queue.count) == 1
//                                expect(subject.queue.first?.viewController).to(be(modalViewController))
//                            }
//                        }
//
//                        context("when animated") {
//                            beforeEach {
//                                subject.lineUp(modalViewController, animated: true)
//                            }
//
//                            it("should add the second view controller to queue") {
//                                expect(subject.queue.count) == 1
//                                expect(subject.queue.first?.viewController).to(be(modalViewController))
//                            }
//                        }
//
//                        context("when NOT animated") {
//                            beforeEach {
//                                subject.lineUp(modalViewController, animated: false)
//                            }
//
//                            it("should add the second view controller to queue") {
//                                expect(subject.queue.count) == 1
//                                expect(subject.queue.first?.viewController).to(be(modalViewController))
//                            }
//                        }
//                    }
//                }
//
//                context("when dismissing view controller; when the root view controller is NOT presenting anything else") {
//                    var modalViewController: FakeUIViewController!
//
//                    beforeEach {
//                        rootViewController.stub(.presentedViewController).andReturn(nil)
//                        rootViewController.stub(.present).andReturn()
//
//                        modalViewController = .init()
//                        modalViewController.stub(.dismiss).andReturn()
//                        subject.lineUp(modalViewController, animated: false)
//                    }
//
//                    afterEach {
//                        modalViewController.resetCallsAndStubs()
//                    }
//
//                    it("should save already presented view controller as modal") {
//                        expect(rootViewController).to(haveReceived(.present, with: modalViewController, false, Argument.anything))
//                    }
//
//                    context("when animated by default") {
//                        beforeEach {
//                            subject.dismiss()
//                        }
//
//                        it("should dismiss current view controller") {
//                            expect(modalViewController).to(haveReceived(.dismiss, with: true, Argument.anything))
//                        }
//                    }
//
//                    context("when animated") {
//                        beforeEach {
//                            subject.dismiss(animated: true)
//                        }
//
//                        it("should dismiss current view controller") {
//                            expect(modalViewController).to(haveReceived(.dismiss, with: true, Argument.anything))
//                        }
//                    }
//
//                    context("when NOT animated") {
//                        beforeEach {
//                            subject.dismiss(animated: false)
//                        }
//
//                        it("should dismiss current view controller") {
//                            expect(modalViewController).to(haveReceived(.dismiss, with: false, Argument.anything))
//                        }
//                    }
//                }
//            }
//        }
//    }
// }
