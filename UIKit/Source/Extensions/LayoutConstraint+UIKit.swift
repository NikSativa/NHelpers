import UIKit

public extension NSLayoutConstraint {
    @discardableResult
    func set(_ priority: UILayoutPriority) -> Self {
        self.priority = priority
        return self
    }

    @discardableResult
    func store(in property: inout [NSLayoutConstraint]) -> Self {
        property.append(self)
        return self
    }

    @discardableResult
    func assign(to property: inout NSLayoutConstraint) -> Self {
        property = self
        return self
    }

    @discardableResult
    func assign(to property: inout NSLayoutConstraint?) -> Self {
        property = self
        return self
    }

    @discardableResult
    func assign<R>(to root: R, path: ReferenceWritableKeyPath<R, NSLayoutConstraint>) -> Self {
        root[keyPath: path] = self
        return self
    }

    @discardableResult
    func assign<R>(to root: R, path: ReferenceWritableKeyPath<R, NSLayoutConstraint?>) -> Self {
        root[keyPath: path] = self
        return self
    }

    @discardableResult
    func activate() -> Self {
        isActive = true
        return self
    }

    @discardableResult
    func deactivate() -> Self {
        isActive = false
        return self
    }
}
