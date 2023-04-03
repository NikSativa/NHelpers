// import NSpry
//
// import NTextOperators
//
// final class TextImager_SingleSpec: QuickSpec {
//    override func spec() {
//        describe("TextImager.Single") {
//            var subject: TextImager!
//
//            beforeEach {
//                subject = TextImager.single(image: .testMake(.five))
//            }
//
//            it("should add text at the end") {
//                expect(subject.image(from: "0")) == .testMake(.five)
//                expect(subject.image(from: "1")) == .testMake(.five)
//            }
//
//            it("should generate unique id and be equatable") {
//                expect(subject) == .single(image: .testMake(.five))
//                expect(subject) != .single(image: .testMake(.four))
//            }
//        }
//    }
// }
