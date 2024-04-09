import SpryKit
import UIKit
import UIKitHelper
import UIKitHelperTestHelpers
import XCTest

final class ViewStylePropertyTests: XCTestCase {
    func test_spec() {
        let view: UIView = .init()
        var style: ViewStyle<ViewStyleProperty> = [
            .backgroundColor(.red),
            .border(.green, 30),
            .shadow(radius: 10, opacity: 0.9, offset: .init(width: 11, height: 11), color: .brown),
            .cornerRadius(20),
            .clipsToBounds(true),
            .tintColor(.yellow)
        ]
        style.apply(to: view)
        XCTAssertStyle(style, beAppliedTo: view)

        style = [
            .backgroundColor(.blue),
            .border(.magenta, 10),
            .shadow(radius: 20, opacity: 0.9, offset: .init(width: 11, height: 11), color: .black),
            .cornerRadius(12),
            .clipsToBounds(false),
            .tintColor(.white)
        ]
        style.apply(to: view)
        XCTAssertStyle(style, beAppliedTo: view)
    }
}
