import Nimble
import NSpry
import Quick
import UIKit

@testable import NFoundation
@testable import NFoundationExtraTestHelpers
@testable import NFoundationTestHelpers

final class ImageProviderSpec: QuickSpec {
    private enum Constant {
        static var bundle: Bundle = .module
    }

    private enum TestImageName: String, ImageRepresentable {
        case fake = "fake_asset_only_for_test"
        case lackImage
    }

    override func spec() {
        describe("ImageProvider") {
            func imageNamed(_ name: String) -> UIImage? {
                return UIImage(named: name, in: Constant.bundle, compatibleWith: nil)
            }

            context("when requested image is absent") {
                var subject: AnyImageProvider<TestImageName>!

                beforeEach {
                    subject = BaseImageProvider(bundle: Constant.bundle).toAny()
                }

                it("should return real image") {
                    expect(subject.image(.fake)) == imageNamed("fake_asset_only_for_test")
                    expect(subject.image(.fake)) != UIImage()
                }

                it("should return empty image") {
                    expect(subject.image(.lackImage)) == UIImage()
                }
            }
        }
    }
}
