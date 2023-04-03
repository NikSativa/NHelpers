import NSpry
import UIKit

import NUIKit

extension CollectionViewStyleProperty: StylePropertyTestable {
    public func isApplied(to collectionView: UICollectionView) -> Bool {
        switch self {
        case .horizontalScrollBar(let enable):
            return collectionView.showsHorizontalScrollIndicator == enable
        case .verticalScrollBar(let enable):
            return collectionView.showsVerticalScrollIndicator == enable
        case .sectionInset(let inset):
            if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
                return flowLayout.sectionInset == inset
            }
        case .cellSize(let size):
            if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
                return flowLayout.itemSize == size
            }
        case .minimumLineSpacing(let spacing):
            if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
                return flowLayout.minimumLineSpacing == spacing
            }
        case .minimumInteritemSpacing(let spacing):
            if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
                return flowLayout.minimumInteritemSpacing == spacing
            }
        }
        return false
    }
}
