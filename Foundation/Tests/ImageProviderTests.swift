import Foundation
import NFoundation
import NSpry
import XCTest

final class ImageProviderTests: XCTestCase {
    private enum Constant {
        static var bundle: Bundle = .module
    }

    private enum TestImageName: String, ImageRepresentable {
        case fake = "fake_asset_only_for_test"
        case lackImage
    }

    func test_image() {
        func imageNamed(_ name: String) -> UIImage? {
            return UIImage(named: name, in: Constant.bundle, compatibleWith: nil)
        }

        let subject: AnyImageProvider<TestImageName> = BaseImageProvider(bundle: Constant.bundle).toAny()
        XCTAssertEqualImage(subject.image(.fake), imageNamed("fake_asset_only_for_test"))
        XCTAssertNotEqualImage(subject.image(.fake), UIImage())
        XCTAssertEqualImage(subject.image(.lackImage), UIImage())
    }
}
