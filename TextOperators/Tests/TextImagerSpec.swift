// import Foundation
// import NSpry
// import UIKit
//
// import NTextOperators
//
// final class TextImagerSpec: QuickSpec {
//    private enum Constant {
//        static let sharedName = "TextImager_shared_behavior"
//        static let sharedKey = "imagings"
//    }
//
//    private struct TestImager: TextImaging {
//        let uniqueID: String
//        init(uniqueID: String) {
//            self.uniqueID = uniqueID
//        }
//
//        func image(from string: String) -> UIImage? {
//            return uniqueID == string ? .testMake(.one) : nil
//        }
//    }
//
//    override func spec() {
//        describe("TextImager") {
//            var subject: TextImager!
//
//            describe("equality") {
//                beforeEach {
//                    subject = .single(image: .testMake(.three)) + .identity
//                }
//
//                it("should be equal") {
//                    expect(subject) == .single(image: .testMake(.three)) + .identity
//                    expect(subject) == .identity + .single(image: .testMake(.three))
//                }
//
//                it("should NOT be equal") {
//                    expect(subject) != .identity
//                    expect(subject) != .smart { _ in return nil } + .identity
//                    expect(subject) != .identity + .smart { _ in return nil }
//                }
//            }
//
//            describe("constructors") {
//                var mock1: TextImaging!
//                var mock2: TextImaging!
//
//                beforeEach {
//                    mock1 = TestImager(uniqueID: "1")
//                    mock2 = TestImager(uniqueID: "2")
//                }
//
//                sharedExamples(Constant.sharedName) { contextInfo in
//                    var formatables: [TextImaging]!
//
//                    beforeEach {
//                        let contextInfo = contextInfo()
//                        formatables = (contextInfo[Constant.sharedKey] as? [TextImaging]) ?? [mock1, mock2]
//                    }
//
//                    it("should be equal") {
//                        expect(subject) == TextImager(formatables)
//                        expect(subject) == TextImager(formatables.reversed())
//                    }
//
//                    it("should NOT be equal") {
//                        expect(subject) != .identity
//                        expect(subject) != .smart { _ in return nil } + .identity
//                        expect(subject) != .identity + .smart { _ in return nil }
//                    }
//
//                    it("should return image one") {
//                        expect(subject.image(from: "1")) == .testMake(.one)
//                    }
//
//                    it("should return image two if can") {
//                        if formatables.count >= 2 {
//                            expect(subject.image(from: "2")) == .testMake(.one)
//                        } else {
//                            expect(subject.image(from: "2")).to(beNil())
//                        }
//                    }
//
//                    it("should not find correct image and return nil") {
//                        expect(subject.image(from: "12")).to(beNil())
//                    }
//                }
//
//                describe("ExpressibleByArrayLiteral") {
//                    context("when array of formatables") {
//                        beforeEach {
//                            subject = .init(arrayLiteral: mock1, mock2)
//                        }
//
//                        itBehavesLike(Constant.sharedName)
//                    }
//
//                    context("when array of formatables") {
//                        beforeEach {
//                            subject = [mock1, mock2]
//                        }
//
//                        itBehavesLike(Constant.sharedName)
//                    }
//                }
//
//                describe("array of formatables") {
//                    beforeEach {
//                        subject = .init([mock1, mock2])
//                    }
//
//                    itBehavesLike(Constant.sharedName)
//                }
//
//                describe("single formatable") {
//                    beforeEach {
//                        subject = .init(mock1)
//                    }
//
//                    itBehavesLike(Constant.sharedName) {
//                        return [Constant.sharedKey: [mock1]]
//                    }
//                }
//
//                describe("array of formaters") {
//                    beforeEach {
//                        subject = .init(imagers: [TextImager(mock1), TextImager(mock2)])
//                    }
//
//                    itBehavesLike(Constant.sharedName)
//                }
//
//                describe("operation 'plus'") {
//                    context("when formatter and formatter") {
//                        beforeEach {
//                            subject = TextImager(mock1) + TextImager(mock2)
//                        }
//
//                        itBehavesLike(Constant.sharedName)
//                    }
//
//                    context("when formatter and formatable") {
//                        beforeEach {
//                            subject = TextImager(mock1) + mock2
//                        }
//
//                        itBehavesLike(Constant.sharedName)
//                    }
//
//                    context("when formatable and formatter") {
//                        beforeEach {
//                            subject = mock1 + TextImager(mock2)
//                        }
//
//                        itBehavesLike(Constant.sharedName)
//                    }
//
//                    context("when formatter and formatable and formatable") {
//                        beforeEach {
//                            subject = mock1 + TextImager(mock2) + mock1
//                        }
//
//                        itBehavesLike(Constant.sharedName)
//                    }
//
//                    context("when formatable and formatable and formatter") {
//                        beforeEach {
//                            subject = TextImager(mock2) + mock1 + mock2
//                        }
//
//                        itBehavesLike(Constant.sharedName)
//                    }
//
//                    context("when formatable and array of formatables") {
//                        beforeEach {
//                            subject = mock1 + [mock2, mock1]
//                        }
//
//                        itBehavesLike(Constant.sharedName)
//                    }
//
//                    context("when formatable and formatable and formatter") {
//                        beforeEach {
//                            subject = TextImager(mock2) + [mock1, mock2]
//                        }
//
//                        itBehavesLike(Constant.sharedName)
//                    }
//                }
//            }
//        }
//    }
// }
//
// internal extension UIImage {
//    private static let testImage = UIImage.colored(.brown)
//    private static let testImage1 = UIImage.colored(.yellow)
//    private static let testImage2 = UIImage.colored(.gray)
//    private static let testImage3 = UIImage.colored(.magenta)
//    private static let testImage4 = UIImage.colored(.green)
//    private static let testImage5 = UIImage.colored(.cyan)
//
//    enum TastableImage {
//        case `default`
//        case one
//        case two
//        case three
//        case four
//        case five
//    }
//
//    /// This function returns a the same UIImage object each time it is called. For example, when you need to use the same image in tests to chech viewState for equality.
//    static func testMake(_ image: TastableImage = .default) -> UIImage {
//        switch image {
//        case .default:
//            return testImage
//        case .one:
//            return testImage1
//        case .two:
//            return testImage2
//        case .three:
//            return testImage3
//        case .four:
//            return testImage4
//        case .five:
//            return testImage5
//        }
//    }
// }
//
// private extension UIImage {
//    static func colored(_ color: UIColor, size: CGSize = .init(width: 1, height: 1)) -> UIImage {
//        return UIGraphicsImageRenderer(size: size).image { context in
//            context.cgContext.setFillColor(color.cgColor)
//            context.fill(CGRect(x: 0, y: 0, width: size.width, height: size.height))
//        }
//    }
// }
