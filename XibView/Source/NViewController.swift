import UIKit

#if canImport(NInject)
import NInject
#endif

open class NViewController: UIViewController {
    private var inited: Bool = false

    public var dismissClosure: () -> Void = {}

    override public init(nibName: String?, bundle: Bundle?) {
        super.init(nibName: nibName, bundle: bundle)
        resolveDependencies()
        commonSetup()
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        resolveDependencies()
        commonSetup()
    }

    /// setup before IBOutlets. use viewDidLoad for outlets
    open func commonSetup() {
        assert(inited == false)
        inited = true
    }

    public func configureWithDefaultNavigationBarBackground() {
        guard let navigationController = navigationController else {
            assertionFailure()
            return
        }

        // horizontal layout is a complex of TableViews
        // can't determine which one is "primary" and adjust navigation bar color (iOS 15+ behavior)
        if #available(iOS 15.0, *) {
            let navigationBarAppearance = UINavigationBarAppearance()
            navigationBarAppearance.configureWithDefaultBackground()
            navigationItem.scrollEdgeAppearance = navigationBarAppearance
            navigationItem.standardAppearance = navigationBarAppearance
            navigationItem.compactAppearance = navigationBarAppearance

            navigationController.setNeedsStatusBarAppearanceUpdate()
        } else {
            assertionFailure("check min available iOS version if needed")
        }
    }
}
