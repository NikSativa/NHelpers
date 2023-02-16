import Foundation
import UIKit

public extension TextImager {
    static func single(image: UIImage) -> TextImager {
        return [SingleImager(image: image)]
    }
}

private struct SingleImager: TextImaging {
    let image: UIImage

    func image(from _: String) -> UIImage? {
        return image
    }

    var uniqueID: String {
        return makeUniqueID() + " image hash: \(image.hashValue)"
    }
}
