import UIKit

open class NCollectionReusableView: UICollectionReusableView {
    private var inited: Bool = false

    override public init(frame: CGRect) {
        super.init(frame: frame)
        commonSetup()
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonSetup()
    }

    open func commonSetup() {
        assert(inited == false)
        inited = true
    }
}
