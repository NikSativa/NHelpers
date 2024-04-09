import UIKit

internal extension UIImage {
    private static let testImage = UIImage.spry.testImage
    private static let testImage1 = UIImage.spry.testImage1
    private static let testImage2 = UIImage.spry.testImage2
    private static let testImage3 = UIImage.spry.testImage3
    private static let testImage4 = UIImage.spry.testImage4

    enum TastableImage {
        case `default`
        case one
        case two
        case three
        case four
    }

    /// This function returns a the same UIImage object each time it is called. For example, when you need to use the same image in tests to chech viewState for equality.
    static func testMake(_ image: TastableImage = .default) -> UIImage {
        switch image {
        case .default:
            return testImage
        case .one:
            return testImage1
        case .two:
            return testImage2
        case .three:
            return testImage3
        case .four:
            return testImage4
        }
    }
}
