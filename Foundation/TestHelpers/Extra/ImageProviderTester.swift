import Foundation
import Nimble
import NSpry
import Quick

import UIKit
@testable import NFoundation

public final class ImageProviderTester {
    public init() {}

    public func test<Name>(_: Name.Type = Name.self, bundle: Bundle)
    where Name: ImageRepresentable & CaseIterable {
        describe(String(reflecting: Name.self)) {
            var subject: AnyImageProvider<Name>!

            beforeEach {
                subject = BaseImageProvider(bundle: bundle).toAny()
            }

            func image(named name: some ImageRepresentable) -> UIImage? {
                return UIImage(named: name.rawValue, in: bundle, compatibleWith: nil)
            }

            for name in Name.allCases {
                it("should contains \(name.rawValue) image") {
                    let description = [
                        String(reflecting: name.self).components(separatedBy: ".").dropFirst().joined(separator: "."),
                        ["\"", name.rawValue, "\""].joined()
                    ].joined(separator: " = ")
                    expect(subject.image(name)).to(equal(image(named: name)), description: description)
                }
            }
        }
    }
}
