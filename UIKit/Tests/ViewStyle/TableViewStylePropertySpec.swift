// import NSpry
// import UIKit
//
// import NUIKit
// import NUIKitExtraTestHelpers
// import NUIKitTestHelpers
//
// final class TableViewStylePropertySpec: QuickSpec {
//    override func spec() {
//        describe("TableViewStyleProperty") {
//            var view: UITableView!
//            var style: ViewStyle<TableViewStyleProperty>!
//
//            beforeEach {
//                view = .init()
//                style = [
//                    .estimatedRowHeight(11),
//                    .rowHeight(22),
//                    .backgroundColor(.red),
//                    .sectionHeaderHeight(33),
//                    .sectionFooterHeight(44),
//                    .separatorColor(.green),
//                    .separatorInset(2),
//                    .separatorStyle(.singleLine)
//                ]
//                style.apply(to: view)
//            }
//
//            it("should be applied to view") {
//                expect(style).to(beAppliedTo(view))
//            }
//
//            it("should be applied to view") { @MainActor in
//                expect(view.estimatedRowHeight).to(beCloseTo(11))
//                expect(view.rowHeight).to(beCloseTo(22))
//                expect(view.backgroundColor) == .red
//                expect(view.sectionHeaderHeight).to(beCloseTo(33))
//                expect(view.sectionFooterHeight).to(beCloseTo(44))
//                expect(view.separatorColor) == .green
//                expect(view.separatorInset) == UIEdgeInsets(top: 0, left: 2, bottom: 0, right: 2)
//                expect(view.separatorStyle) == .singleLine
//            }
//
//            context("when overriding style") {
//                beforeEach {
//                    style = [
//                        .estimatedRowHeight(22),
//                        .rowHeight(33),
//                        .backgroundColor(.green),
//                        .sectionHeaderHeight(44),
//                        .sectionFooterHeight(55),
//                        .separatorColor(.red),
//                        .separatorInset(1),
//                        .separatorStyle(.none)
//                    ]
//                    style.apply(to: view)
//                }
//
//                it("should be applied to view") {
//                    expect(style).to(beAppliedTo(view))
//                }
//
//                it("should be applied to view") { @MainActor in
//                    expect(view.estimatedRowHeight).to(beCloseTo(22))
//                    expect(view.rowHeight).to(beCloseTo(33))
//                    expect(view.backgroundColor) == .green
//                    expect(view.sectionHeaderHeight).to(beCloseTo(44))
//                    expect(view.sectionFooterHeight).to(beCloseTo(55))
//                    expect(view.separatorColor) == .red
//                    expect(view.separatorInset) == UIEdgeInsets(top: 0, left: 1, bottom: 0, right: 1)
//                    expect(view.separatorStyle) == UITableViewCell.SeparatorStyle.none
//                }
//            }
//        }
//    }
// }
