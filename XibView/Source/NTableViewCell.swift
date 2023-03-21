import UIKit

open class NTableViewCell: UITableViewCell {
    private var inited: Bool = false

    override public init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
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
