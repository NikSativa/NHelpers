import UIKit

extension UIImage {
    private static let testImage = UIImage.colored(.brown)
    private static let testImage1 = UIImage.colored(.yellow)
    private static let testImage2 = UIImage.colored(.gray)
    private static let testImage3 = UIImage.colored(.magenta)
    private static let testImage4 = UIImage.colored(.green)
    private static let testImage5 = UIImage.colored(.cyan)

    enum TastableImage {
        case `default`
        case one
        case two
        case three
        case four
        case five
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
        case .five:
            return testImage5
        }
    }
}

public func isEqual(_ lhs: UIImage?, _ rhs: UIImage?) -> Bool {
    if lhs == nil, rhs == nil {
        return true
    }

    guard let lhs, let rhs else {
        return false
    }

    return lhs.size == rhs.size
        && lhs.pngData() == rhs.pngData()
}
