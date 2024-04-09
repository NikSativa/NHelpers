import Foundation
import UIKitHelper
import XCTest

@inline(__always)
public func XCTAssertStyle<T: StylePropertyTestable>(_ style: ViewStyle<T>,
                                                     beAppliedTo view: T.ViewType?,
                                                     file: StaticString = #file,
                                                     line: UInt = #line) {
    guard let view else {
        XCTFail("\(T.ViewType.self) is nil", file: file, line: line)
        return
    }

    let failed = style.notAppliedProperty(to: view)
    XCTAssertNil(failed, "\(String(describing: failed))", file: file, line: line)
}
