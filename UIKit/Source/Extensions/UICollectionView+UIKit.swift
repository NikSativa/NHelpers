import UIKit

public extension UICollectionView {
    func register(cellClass: (some UICollectionViewCell).Type) {
        let className = id(of: cellClass)
        register(cellClass, forCellWithReuseIdentifier: className)
    }

    func register(cellType: (some UICollectionViewCell).Type,
                  bundle: Bundle? = nil) {
        let className = id(of: cellType)
        let nib = UINib(nibName: className, bundle: bundle)
        register(nib, forCellWithReuseIdentifier: className)
    }

    func dequeueReusableCell<T: UICollectionViewCell>(ofType type: T.Type = T.self,
                                                      for indexPath: IndexPath) -> T {
        // swiftlint:disable:next force_cast
        return dequeueReusableCell(withReuseIdentifier: id(of: type),
                                   for: indexPath) as! T
    }

    func register(_ type: (some UICollectionReusableView).Type,
                  forSupplementaryViewOfKind kind: String,
                  bundle: Bundle? = nil) {
        let className = id(of: type)
        let nib = UINib(nibName: className, bundle: bundle)
        register(nib, forSupplementaryViewOfKind: kind, withReuseIdentifier: id(of: type))
    }

    func dequeueReusableSupplementaryView<T: UICollectionReusableView>(_ type: T.Type = T.self,
                                                                       ofKind kind: String,
                                                                       for indexPath: IndexPath) -> T {
        // swiftlint:disable:next force_cast
        return dequeueReusableSupplementaryView(ofKind: kind,
                                                withReuseIdentifier: id(of: type),
                                                for: indexPath) as! T
    }

    private func id(of type: (some UIView).Type) -> String {
        return String(describing: type)
    }
}
