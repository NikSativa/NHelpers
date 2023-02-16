import UIKit

public extension UITableView {
    func applyAutomaticDimension() {
        estimatedRowHeight = UITableView.automaticDimension
        rowHeight = UITableView.automaticDimension
        sectionHeaderHeight = UITableView.automaticDimension
    }

    // MARK: - Cell

    func register<T: UITableViewCell>(cellClass type: T.Type) {
        let className = id(type: type)
        register(type, forCellReuseIdentifier: className)
    }

    func register<T: UITableViewCell>(cellType: T.Type,
                                      bundle: Bundle? = nil) {
        let info = nib(type: cellType, bundle: bundle)
        register(info.nib, forCellReuseIdentifier: info.id)
    }

    func dequeueReusableCell<T: UITableViewCell>(ofType type: T.Type = T.self,
                                                 for indexPath: IndexPath) -> T {
        // swiftlint:disable:next force_cast
        return dequeueReusableCell(withIdentifier: id(type: type), for: indexPath) as! T
    }

    // MARK: - Header/Footer

    func register<T: UITableViewHeaderFooterView>(headerFooterViewType type: T.Type,
                                                  bundle: Bundle? = nil) {
        let info = nib(type: type, bundle: bundle)
        register(info.nib, forHeaderFooterViewReuseIdentifier: info.id)
    }

    func register<T: UITableViewHeaderFooterView>(headerFooterViewClass type: T.Type) {
        let className = id(type: type)
        register(type, forHeaderFooterViewReuseIdentifier: className)
    }

    func dequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView>(ofType type: T.Type = T.self) -> T {
        // swiftlint:disable:next force_cast
        return dequeueReusableHeaderFooterView(withIdentifier: id(type: type)) as! T
    }

    // MARK: -

    private func nib<T: UIView>(type: T.Type,
                                bundle: Bundle? = nil) -> (nib: UINib, id: String) {
        let className = id(type: type)
        let nib = UINib(nibName: className, bundle: bundle)
        return (nib, className)
    }

    private func id<T: UIView>(type: T.Type) -> String {
        return String(describing: type)
    }
}
