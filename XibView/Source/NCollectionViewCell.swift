import UIKit

#if canImport(NInject)
import NInject
#endif

open class NCollectionViewCell: UICollectionViewCell {
    private var inited: Bool = false

    override public init(frame: CGRect) {
        super.init(frame: frame)
        resolveDependencies()
        commonSetup()
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        resolveDependencies()
    }

    override open func awakeFromNib() {
        super.awakeFromNib()
        commonSetup()
    }

    open func commonSetup() {
        assert(inited == false)
        inited = true
    }
}
