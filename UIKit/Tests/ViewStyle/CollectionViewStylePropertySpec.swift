import Nimble
import NSpry
import Quick
import UIKit

@testable import NUIKit
@testable import NUIKitExtraTestHelpers
@testable import NUIKitTestHelpers

final class CollectionViewStylePropertySpec: QuickSpec {
    override func spec() {
        describe("CollectionViewStyleProperty") {
            var view: UICollectionView!
            var style: ViewStyle<CollectionViewStyleProperty>!

            beforeEach {
                view = UICollectionView(frame: .init(x: 0, y: 0, width: 100, height: 100),
                                        collectionViewLayout: UICollectionViewFlowLayout())
                style = [
                    .horizontalScrollBar(true),
                    .verticalScrollBar(true),
                    .sectionInset(.init(top: 1, left: 1, bottom: 1, right: 1)),
                    .cellSize(.init(width: 2, height: 2)),
                    .minimumLineSpacing(3),
                    .minimumInteritemSpacing(4)
                ]

                style.apply(to: view)
            }

            it("should be applied to view") {
                expect(style).to(beAppliedTo(view))
            }

            it("should be applied to view") { @MainActor in
                expect(view.showsHorizontalScrollIndicator).to(beTrue())
                expect(view.showsVerticalScrollIndicator).to(beTrue())

                let layout = (view.collectionViewLayout as? UICollectionViewFlowLayout)
                expect(layout?.sectionInset) == .init(top: 1, left: 1, bottom: 1, right: 1)
                expect(layout?.itemSize) == .init(width: 2, height: 2)
                expect(layout?.minimumLineSpacing).to(beCloseTo(3))
                expect(layout?.minimumInteritemSpacing).to(beCloseTo(4))
            }

            context("when overriding style") {
                beforeEach {
                    style = [
                        .horizontalScrollBar(false),
                        .verticalScrollBar(false),
                        .sectionInset(.init(top: 2, left: 2, bottom: 2, right: 2)),
                        .cellSize(.init(width: 3, height: 3)),
                        .minimumLineSpacing(4),
                        .minimumInteritemSpacing(5)
                    ]

                    style.apply(to: view)
                }

                it("should be applied to view") {
                    expect(style).to(beAppliedTo(view))
                }

                it("should be applied to view") { @MainActor in
                    expect(view.showsHorizontalScrollIndicator).to(beFalse())
                    expect(view.showsVerticalScrollIndicator).to(beFalse())

                    let layout = (view.collectionViewLayout as? UICollectionViewFlowLayout)
                    expect(layout?.sectionInset) == .init(top: 2, left: 2, bottom: 2, right: 2)
                    expect(layout?.itemSize) == .init(width: 3, height: 3)
                    expect(layout?.minimumLineSpacing).to(beCloseTo(4))
                    expect(layout?.minimumInteritemSpacing).to(beCloseTo(5))
                }
            }
        }
    }
}
