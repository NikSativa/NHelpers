import Foundation
import UIKit

public extension TextImager {
    static func smart(_ imager: @escaping (String) -> UIImage?) -> TextImager {
        return [SmartImager(imager: imager)]
    }
}

private struct SmartImager: TextImaging {
    typealias Imager = (String) -> UIImage?
    let imager: Imager

    init(imager: @escaping Imager) {
        self.imager = imager
    }

    func image(from string: String) -> UIImage? {
        return imager(string)
    }
}
