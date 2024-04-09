import UIKit

open class GradientView: UIView {
    override public init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        backgroundColor = .clear
    }

    override open var layer: CAGradientLayer {
        // swiftlint:disable:next force_cast
        return super.layer as! CAGradientLayer
    }

    override open class var layerClass: AnyClass {
        return CAGradientLayer.self
    }
}
