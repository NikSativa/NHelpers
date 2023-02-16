import UIKit

public class TransparentTouchView: UIView {
    public typealias Callback = () -> Void
    public var callback: Callback?

    public typealias ExcludedViews = () -> [UIView]
    public var excluded: ExcludedViews = {
        return []
    }

    public var exclusive: ExcludedViews = {
        return []
    }

    override public func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        for sub in subviews {
            if let _ = sub.myhitTest(sub.convert(point, from: self)) {
                return true
            }
        }

        for view in excluded() {
            if let _ = view.myhitTest(view.convert(point, from: self)) {
                return false
            }
        }

        for view in exclusive() {
            if let _ = view.myhitTest(view.convert(point, from: self)) {
                return true
            }
        }

        if super.point(inside: point, with: event) {
            callback?()
        }

        return false
    }

    override public func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        if isUserInteractionEnabled, !isHidden {
            for view in exclusive() {
                if let sub = view.myhitTest(view.convert(point, from: self)) {
                    return sub
                }
            }
        }

        return super.hitTest(point, with: event)
    }
}

private extension UIView {
    func myhitTest(_ point: CGPoint) -> UIView? {
        if isHidden {
            return nil
        }

        if let t = hitTest(point, with: nil) {
            return t
        }

        for sub in subviews {
            if let t = sub.myhitTest(sub.convert(point, from: self)) {
                return t
            }
        }
        return nil
    }
}
