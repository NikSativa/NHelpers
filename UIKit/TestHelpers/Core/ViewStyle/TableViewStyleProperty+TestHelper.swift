import NSpry
import UIKit

@testable import NUIKit

extension TableViewStyleProperty: StylePropertyTestable {
    public static func ==(lhs: TableViewStyleProperty, rhs: TableViewStyleProperty) -> Bool {
        switch (rhs, lhs) {
        case (.estimatedRowHeight(let height), .estimatedRowHeight(let height1)):
            return height == height1
        case (.separatorStyle(let style), .separatorStyle(let style1)):
            return style == style1
        case (.rowHeight(let height), .rowHeight(let height1)):
            return height == height1
        case (.sectionHeaderHeight(let height), .sectionHeaderHeight(let height1)):
            return height == height1
        case (.sectionFooterHeight(let height), .sectionFooterHeight(let height1)):
            return height == height1
        case (.separatorInset(let margin), .separatorInset(let margin1)):
            return margin == margin1
        case (.separatorColor(let color), .separatorColor(let color1)):
            return isEqual(color, color1)
        case (.backgroundColor(let color), .backgroundColor(let color1)):
            return isEqual(color, color1)

        case (.backgroundColor, _),
             (.estimatedRowHeight, _),
             (.rowHeight, _),
             (.sectionFooterHeight, _),
             (.sectionHeaderHeight, _),
             (.separatorColor, _),
             (.separatorInset, _),
             (.separatorStyle, _):
            return false
        }
    }

    public func isApplied(to tableView: UITableView) -> Bool {
        switch self {
        case .estimatedRowHeight(let height):
            return tableView.estimatedRowHeight == height
        case .separatorStyle(let style):
            return tableView.separatorStyle == style
        case .rowHeight(let height):
            return tableView.rowHeight == height
        case .sectionHeaderHeight(let height):
            return tableView.sectionHeaderHeight == height
        case .sectionFooterHeight(let height):
            return tableView.sectionFooterHeight == height
        case .separatorInset(let margin):
            let actualInsets = tableView.separatorInset
            return (actualInsets.left == margin) && (actualInsets.right == margin)
        case .separatorColor(let color):
            return isEqual(color, tableView.separatorColor)
        case .backgroundColor(let color):
            return isEqual(color, tableView.backgroundColor)
        }
    }

    private func compare(view: UIView, with tableView: UITableView) -> Bool {
        if let frame = tableView.tableFooterView?.frame {
            return frame.width == view.frame.width
                && frame.height == view.frame.height
        }
        return false
    }
}
