import SpryKit
import UIKit
import UIKitHelper
import UIKitHelperTestHelpers
import XCTest

final class CollectionViewStylePropertyTests: XCTestCase {
    func test_spec() {
        let view: UICollectionView = .init(frame: .init(x: 0, y: 0, width: 100, height: 100),
                                           collectionViewLayout: UICollectionViewFlowLayout())
        var style: ViewStyle<CollectionViewStyleProperty> = [
            .horizontalScrollBar(true),
            .verticalScrollBar(true),
            .sectionInset(.init(top: 1, left: 1, bottom: 1, right: 1)),
            .cellSize(.init(width: 2, height: 2)),
            .minimumLineSpacing(3),
            .minimumInteritemSpacing(4)
        ]

        style.apply(to: view)
        XCTAssertStyle(style, beAppliedTo: view)

        style = [
            .horizontalScrollBar(false),
            .verticalScrollBar(false),
            .sectionInset(.init(top: 2, left: 2, bottom: 2, right: 2)),
            .cellSize(.init(width: 3, height: 3)),
            .minimumLineSpacing(4),
            .minimumInteritemSpacing(5)
        ]

        style.apply(to: view)
        XCTAssertStyle(style, beAppliedTo: view)
    }
}
