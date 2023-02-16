import Foundation
import UIKit

public class CircleButton: UIButton {
    override public var bounds: CGRect {
        didSet {
            layer.cornerRadius = min(bounds.width, bounds.height) / 2
        }
    }

    override public init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    private func setup() {
        layer.masksToBounds = true
        clipsToBounds = true
    }

    override public func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = min(bounds.width, bounds.height) / 2
    }
}
