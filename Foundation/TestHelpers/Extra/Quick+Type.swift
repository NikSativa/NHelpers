import Foundation
import Quick

public func describeHeader<T>(_ type: T.Type, closure: () -> Void) {
    describe(String(describing: type), closure: closure)
}

public func fdescribeHeader<T>(_ type: T.Type, closure: () -> Void) {
    fdescribe(String(describing: type), closure: closure)
}

public func xdescribeHeader<T>(_ type: T.Type, closure: () -> Void) {
    xdescribe(String(describing: type), closure: closure)
}
