import Foundation
import UIKit

public enum UITestHelper {
    public static func prepareWindowIfNeeded(with root: UIViewController = UIViewController()) {
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.makeKeyAndVisible()

        window.layer.speed = 100
        window.rootViewController = root
    }

    public enum ViewController {
        public static func test(_ viewController: UIViewController, file _: String = #file, _: Int = #line) {
            UITestHelper.prepareWindowIfNeeded(with: viewController)
        }
    }

    public enum View {
        public enum Layout {
            public enum Value {
                case flexible
                case equalToSuperview
            }

            case fixed(CGSize)
            case size(Value, Value)

            public static let flexible = Layout.size(.flexible, .flexible)
            public static let flexibleWidth = Layout.size(.flexible, .equalToSuperview)
            public static let flexibleHeight = Layout.size(.equalToSuperview, .flexible)
            public static let equalToSuperview = Layout.size(.equalToSuperview, .equalToSuperview)
        }

        public static func test(_ view: UIView, layout: Layout = .flexible) {
            switch view {
            case is UITableViewCell:
                fatalError("Please use testTableViewCell(), otherwise your UITableViewCell may not be sized properly.")
            case is UICollectionViewCell:
                fatalError("Please use testCollectionViewCell() to ensure proper behavior.")
            default:
                break
            }

            let viewController = UIViewController()
            view.translatesAutoresizingMaskIntoConstraints = false
            viewController.view.addSubview(view)

            let applyLowPriority = { (dimension: NSLayoutDimension) -> NSLayoutConstraint in
                let constraint = dimension.constraint(equalToConstant: 0)
                constraint.priority = UILayoutPriority.fittingSizeLevel
                return constraint
            }
            view.topAnchor.constraint(equalTo: viewController.view.topAnchor).isActive = true
            view.leftAnchor.constraint(equalTo: viewController.view.leftAnchor).isActive = true

            switch layout {
            case .fixed(let size):
                view.widthAnchor.constraint(equalToConstant: size.width).isActive = true
                view.heightAnchor.constraint(equalToConstant: size.height).isActive = true
            case .size(.flexible, .flexible):
                applyLowPriority(view.widthAnchor).isActive = true
                applyLowPriority(view.heightAnchor).isActive = true
            case .size(.flexible, .equalToSuperview):
                applyLowPriority(view.widthAnchor).isActive = true
                view.heightAnchor.constraint(equalTo: viewController.view.heightAnchor).isActive = true
            case .size(.equalToSuperview, .flexible):
                view.widthAnchor.constraint(equalTo: viewController.view.widthAnchor).isActive = true
                applyLowPriority(view.heightAnchor).isActive = true
            case .size(.equalToSuperview, .equalToSuperview):
                view.widthAnchor.constraint(equalTo: viewController.view.widthAnchor).isActive = true
                view.heightAnchor.constraint(equalTo: viewController.view.heightAnchor).isActive = true
            }

            ViewController.test(viewController)
        }
    }

    public enum TableView {
        private class TestTableView: UITableView {
            var strongDataSource: NSObject?
        }

        public static func test<T: UITableViewCell>(height: CGFloat = UITableView.automaticDimension) -> T {
            let nibName = String(describing: T.self)
            let delegateAndDataSource = SingleTableViewHeaderFooterViewDataSource(reuseIdentifier: nibName, height: height)

            let tableView = TestTableView()
            tableView.strongDataSource = delegateAndDataSource
            tableView.delegate = delegateAndDataSource
            tableView.dataSource = delegateAndDataSource

            let bundle = Bundle(for: T.self)
            let nib = UINib(nibName: nibName, bundle: bundle)
            tableView.register(nib, forCellReuseIdentifier: nibName)

            View.test(tableView, layout: .equalToSuperview)

            let cell = tableView.dequeueReusableCell(withIdentifier: delegateAndDataSource.reuseIdentifier)
            delegateAndDataSource.header = cell
            return cell as! T
        }

        private class SingleTableViewCellDataSource: NSObject, UITableViewDataSource, UITableViewDelegate {
            let reuseIdentifier: String
            let height: CGFloat
            var cell: UITableViewCell!

            init(reuseIdentifier: String, height: CGFloat) {
                self.reuseIdentifier = reuseIdentifier
                self.height = height
            }

            func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
                return 1
            }

            func tableView(_: UITableView, cellForRowAt _: IndexPath) -> UITableViewCell {
                return cell
            }

            func tableView(_: UITableView, estimatedHeightForRowAt _: IndexPath) -> CGFloat {
                return 30
            }

            func tableView(_: UITableView, heightForRowAt _: IndexPath) -> CGFloat {
                return height
            }
        }

        public static func test<T: UITableViewHeaderFooterView>(height: CGFloat = UITableView.automaticDimension) -> T {
            let nibName = String(describing: T.self)
            let delegateAndDataSource = SingleTableViewHeaderFooterViewDataSource(reuseIdentifier: nibName, height: height)

            let tableView = TestTableView()
            tableView.strongDataSource = delegateAndDataSource
            tableView.delegate = delegateAndDataSource
            tableView.dataSource = delegateAndDataSource

            let bundle = Bundle(for: T.self)
            let nib = UINib(nibName: nibName, bundle: bundle)
            tableView.register(nib, forHeaderFooterViewReuseIdentifier: nibName)

            View.test(tableView, layout: .equalToSuperview)

            let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: delegateAndDataSource.reuseIdentifier)
            delegateAndDataSource.header = header
            return header as! T
        }

        private class SingleTableViewHeaderFooterViewDataSource: NSObject, UITableViewDataSource, UITableViewDelegate {
            let reuseIdentifier: String
            let height: CGFloat
            var header: UIView!

            init(reuseIdentifier: String, height: CGFloat) {
                self.reuseIdentifier = reuseIdentifier
                self.height = height
            }

            func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
                return 0
            }

            func tableView(_: UITableView, cellForRowAt _: IndexPath) -> UITableViewCell {
                return UITableViewCell()
            }

            func tableView(_: UITableView, viewForHeaderInSection _: Int) -> UIView? {
                return header
            }

            func tableView(_: UITableView, heightForHeaderInSection _: Int) -> CGFloat {
                return height
            }

            func tableView(_: UITableView, heightForRowAt _: IndexPath) -> CGFloat {
                return UITableView.automaticDimension
            }
        }
    }

    public enum CollectionView {
        private class TestCollectionView: UICollectionView {
            var strongDataSource: NSObject?
        }

        public static func test<T: UICollectionViewCell>(size: CGSize? = nil) -> T {
            let nibName = String(describing: T.self)
            let dataSource = SingleCollectionViewCellDataSource(reuseIdentifier: nibName)

            let flowLayout = UICollectionViewFlowLayout()
            flowLayout.itemSize = size ?? CGSize(width: 300, height: 300)

            let collectionView = TestCollectionView(frame: .zero, collectionViewLayout: flowLayout)
            collectionView.strongDataSource = dataSource
            collectionView.delegate = dataSource
            collectionView.dataSource = dataSource
            collectionView.isPrefetchingEnabled = false

            let bundle = Bundle(for: T.self)
            let nib = UINib(nibName: nibName, bundle: bundle)
            collectionView.register(nib, forCellWithReuseIdentifier: nibName)

            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: dataSource.reuseIdentifier, for: [0, 0])
            dataSource.cell = cell

            View.test(collectionView, layout: .equalToSuperview)

            return cell as! T
        }

        private class SingleCollectionViewCellDataSource: NSObject, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
            let reuseIdentifier: String
            var cell: UICollectionViewCell!

            init(reuseIdentifier: String) {
                self.reuseIdentifier = reuseIdentifier
            }

            func numberOfSections(in _: UICollectionView) -> Int {
                return 1
            }

            func collectionView(_: UICollectionView, numberOfItemsInSection _: Int) -> Int {
                return 1
            }

            func collectionView(_: UICollectionView, cellForItemAt _: IndexPath) -> UICollectionViewCell {
                return cell
            }
        }
    }
}
