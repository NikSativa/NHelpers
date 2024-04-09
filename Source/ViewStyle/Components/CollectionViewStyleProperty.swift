import UIKit

public enum CollectionViewStyleProperty: StyleProperty {
    case horizontalScrollBar(Bool)
    case verticalScrollBar(Bool)
    case sectionInset(UIEdgeInsets)
    case cellSize(CGSize)
    case minimumLineSpacing(CGFloat)
    case minimumInteritemSpacing(CGFloat)
}

// MARK: - ApplicableStyleProperty

extension CollectionViewStyleProperty: ApplicableStyleProperty {
    public func apply(to collectionView: UICollectionView) {
        switch self {
        case .horizontalScrollBar(let enable):
            collectionView.showsHorizontalScrollIndicator = enable
        case .verticalScrollBar(let enable):
            collectionView.showsVerticalScrollIndicator = enable
        case .sectionInset(let inset):
            (collectionView.collectionViewLayout as? UICollectionViewFlowLayout)?.sectionInset = inset
        case .cellSize(let size):
            (collectionView.collectionViewLayout as? UICollectionViewFlowLayout)?.itemSize = size
        case .minimumLineSpacing(let spacing):
            (collectionView.collectionViewLayout as? UICollectionViewFlowLayout)?.minimumLineSpacing = spacing
        case .minimumInteritemSpacing(let spacing):
            (collectionView.collectionViewLayout as? UICollectionViewFlowLayout)?.minimumInteritemSpacing = spacing
        }
    }
}
