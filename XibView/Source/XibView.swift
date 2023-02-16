import UIKit

#if canImport(NInject)
import NInject
#endif

private extension Foundation.Bundle {
    struct Info {
        let bundle: Bundle
        let nibName: String
    }

    static func module(for className: AnyClass) -> Info {
        let candidates: [URL] = {
            var candidates: [Bundle] = []
            candidates += Bundle.allBundles
            candidates += [
                Bundle.main,
                Bundle(for: className)
            ]

            return candidates.flatMap { bundle in
                return [
                    bundle.resourceURL, // Bundle should be present here when the package is linked into an App.
                    bundle.resourceURL?.deletingLastPathComponent(), // Bundle should be present here when the package is linked into a framework.
                    bundle.bundleURL, // For command-line tools.
                    bundle.bundleURL.deletingLastPathComponent() // Bundle should be present here when the package is linked into a framework.
                ].compactMap {
                    return $0
                }
            }
        }()

        let reflection = String(reflecting: className).components(separatedBy: ".")
        let bundleNames = [
            ["NHelpers", reflection[0]],
            [reflection[0], reflection[0]],
            [reflection[0].replacingOccurrences(of: "Tests", with: "", options: .backwards, range: nil), reflection[0]],
            [reflection[0].replacingOccurrences(of: "Tests", with: "", options: .backwards, range: nil) + "-ios", reflection[0]]
        ].map {
            return $0.joined(separator: "_") + ".bundle"
        }

        for bundleName in bundleNames {
            for candidate in candidates {
                let bundlePath = candidate.appendingPathComponent(bundleName)
                if let bundle = Bundle(url: bundlePath) {
                    return .init(bundle: bundle,
                                 nibName: reflection[1])
                }
            }
        }

        return .init(bundle: .main,
                     nibName: reflection[1])
    }
}

open class XibView: UIView {
    public var isMainXibView: Bool {
        return internalView != nil
    }

    private var internalView: UIView!

    open func commonSetup() {}

    private static func loadView(withFilesOwner filesOwner: XibView) -> XibView {
        let classType: UIView.Type = type(of: filesOwner)
        let info = Bundle.module(for: classType)
        let views = info.bundle.loadNibNamed(info.nibName,
                                             owner: filesOwner,
                                             options: nil)
        guard let firstSubview = views?.first as? XibView else {
            fatalError("Failed to unwrap nib objects for nibName: \(info.nibName). Does the nib exist?")
        }

        assert(type(of: firstSubview) == classType, "The type of the first subview (\(type(of: firstSubview))) is incorrect. It should be \(classType). Check your .xib.")
        return firstSubview
    }

    override public required init(frame: CGRect) {
        super.init(frame: frame)
        initNib()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        if internalView == nil, super.subviews.isEmpty {
            initNib()
        }
    }

    private func initNib() {
        resolveDependencies()

        internalView = type(of: self).loadView(withFilesOwner: self)
        internalView.backgroundColor = .clear
        internalView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(internalView)

        NSLayoutConstraint.activate([
            internalView.leadingAnchor.constraint(equalTo: leadingAnchor),
            internalView.trailingAnchor.constraint(equalTo: trailingAnchor),
            internalView.topAnchor.constraint(equalTo: topAnchor),
            internalView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])

        commonSetup()
    }

    override open var preservesSuperviewLayoutMargins: Bool {
        get {
            return internalView?.preservesSuperviewLayoutMargins ?? super.preservesSuperviewLayoutMargins
        }
        set {
            if let internalView = internalView {
                internalView.preservesSuperviewLayoutMargins = newValue
            }
            super.preservesSuperviewLayoutMargins = newValue
        }
    }
}
