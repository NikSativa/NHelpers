import UIKit

open class NViewController: UIViewController {
    private var inited: Bool = false
    public var dismissClosure: () -> Void = {}

    override public init(nibName: String?, bundle: Bundle?) {
        super.init(nibName: nibName, bundle: bundle)
        commonSetup()
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonSetup()
    }

    /// setup before IBOutlets. use viewDidLoad for outlets
    open func commonSetup() {
        assert(inited == false)
        inited = true
    }
}
