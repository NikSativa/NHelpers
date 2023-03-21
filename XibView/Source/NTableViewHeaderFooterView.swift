import UIKit

open class NTableViewHeaderFooterView: UITableViewHeaderFooterView {
    private var inited: Bool = false

    override public init(reuseIdentifier id: String?) {
        super.init(reuseIdentifier: id)
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
