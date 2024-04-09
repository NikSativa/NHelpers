import SpryKit
import UIKit
import UIKitHelper
import UIKitHelperTestHelpers
import XCTest

final class ViewStyleTests: XCTestCase {
    private typealias Style = ViewStyle<LabelStyleProperty>
    private enum Constant {
        static let softBlackStyle: Style = [.textColor(.black)]

        static let brandonRegular15SoftBlack: LabelStyleProperty = .textFont(.systemFont(ofSize: 10))
        static let brandonRegular15SoftBlackStyle: Style = [brandonRegular15SoftBlack]
    }

    func test_spec() {
        let label: UILabel = .init()
        var style: ViewStyle<LabelStyleProperty> = ViewStyle(.backgroundColor(.red))

        // apply first random style
        style.apply(to: label)
        XCTAssertStyle(style, beAppliedTo: label)

        // style constructor
        style = Constant.softBlackStyle + Constant.brandonRegular15SoftBlack
        let expected: Style = [
            .textColor(.black),
            .textFont(.systemFont(ofSize: 10))
        ]
        XCTAssertEqual(expected, style)

        // apply style
        Constant.softBlackStyle.apply(to: label)
        XCTAssertStyle(Constant.softBlackStyle, beAppliedTo: label)

        // style + style
        style = Constant.softBlackStyle + Constant.brandonRegular15SoftBlackStyle
        style.apply(to: label)
        XCTAssertStyle(style, beAppliedTo: label)

        // style + property
        style = Constant.softBlackStyle + Constant.brandonRegular15SoftBlack
        style.apply(to: label)
        XCTAssertStyle(style, beAppliedTo: label)

        // property + style
        style = Constant.brandonRegular15SoftBlack + Constant.softBlackStyle
        style.apply(to: label)
        XCTAssertStyle(style, beAppliedTo: label)

        // += style
        style = Constant.softBlackStyle
        style += Constant.brandonRegular15SoftBlackStyle
        style.apply(to: label)
        XCTAssertStyle(style, beAppliedTo: label)

        // += property
        style = Constant.softBlackStyle
        style += Constant.brandonRegular15SoftBlack
        style.apply(to: label)
        XCTAssertStyle(style, beAppliedTo: label)
    }
}
