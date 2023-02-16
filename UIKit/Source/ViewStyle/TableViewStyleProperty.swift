import UIKit

public enum TableViewStyleProperty: StyleProperty {
    case estimatedRowHeight(CGFloat)
    case rowHeight(CGFloat)
    case backgroundColor(UIColor)
    case sectionHeaderHeight(CGFloat)
    case sectionFooterHeight(CGFloat)
    case separatorColor(UIColor)
    case separatorInset(CGFloat)
    case separatorStyle(UITableViewCell.SeparatorStyle)
}

// MARK: - ApplicableStyleProperty

extension TableViewStyleProperty: ApplicableStyleProperty {
    public func apply(to tableView: UITableView) {
        switch self {
        case .estimatedRowHeight(let height):
            tableView.estimatedRowHeight = height
        case .separatorStyle(let style):
            tableView.separatorStyle = style
        case .rowHeight(let height):
            tableView.rowHeight = height
        case .sectionHeaderHeight(let height):
            tableView.sectionHeaderHeight = height
        case .sectionFooterHeight(let height):
            tableView.sectionFooterHeight = height
        case .separatorInset(let margin):
            let insets = UIEdgeInsets(top: 0, left: margin, bottom: 0, right: margin)
            tableView.separatorInset = insets
        case .separatorColor(let color):
            tableView.separatorColor = color
        case .backgroundColor(let color):
            tableView.backgroundColor = color
        }
    }
}
