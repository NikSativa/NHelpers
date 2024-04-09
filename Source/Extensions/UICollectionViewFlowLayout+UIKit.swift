import UIKit

public extension UICollectionViewFlowLayout {
    func applyAutomaticDimension() {
        estimatedItemSize = Self.automaticSize
    }
}
