import Foundation
import UIKit

public extension TextImager {
    static var identity: TextImager {
        return [IdentityImager()]
    }
}

private struct IdentityImager: TextImaging {
    func image(from _: String) -> UIImage? {
        return nil
    }
}
