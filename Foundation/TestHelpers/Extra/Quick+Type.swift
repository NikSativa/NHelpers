import Foundation
import Quick

public func describeHeader(_ type: (some Any).Type, closure: () -> Void) {
    describe(String(describing: type), closure: closure)
}

public func fdescribeHeader(_ type: (some Any).Type, closure: () -> Void) {
    fdescribe(String(describing: type), closure: closure)
}

public func xdescribeHeader(_ type: (some Any).Type, closure: () -> Void) {
    xdescribe(String(describing: type), closure: closure)
}
