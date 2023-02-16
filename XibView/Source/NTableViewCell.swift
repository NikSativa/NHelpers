import UIKit

#if canImport(NInject)
import NInject
#endif

open class NTableViewCell: UITableViewCell {
    private var inited: Bool = false

    override public init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
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
