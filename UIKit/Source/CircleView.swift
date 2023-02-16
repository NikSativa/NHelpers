import UIKit

open class CircleView: UIView {
    public var isEnabled: Bool = true {
        didSet {
            if isEnabled != oldValue {
                update()
            }
        }
    }

    override public var bounds: CGRect {
        didSet {
            if bounds.size != oldValue.size {
                update()
            }
        }
    }

    override public init(frame: CGRect) {
        super.init(frame: frame)
        commonSetup()
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonSetup()
    }

    private func commonSetup() {
        layer.masksToBounds = true
        clipsToBounds = true
    }

    override public func layoutSubviews() {
        super.layoutSubviews()
        update()
    }

    private func update() {
        if isEnabled {
            layer.cornerRadius = min(bounds.width, bounds.height) / 2
        } else {
            layer.cornerRadius = 0
        }
    }
}
