import UIKit

#if canImport(NInject)
import NInject
#endif

open class NTableViewHeaderFooterView: UITableViewHeaderFooterView {
    private var inited: Bool = false

    override public init(reuseIdentifier id: String?) {
        super.init(reuseIdentifier: id)
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
