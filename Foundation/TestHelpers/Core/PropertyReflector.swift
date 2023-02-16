import Foundation

public final class PropertyReflector {
    private var properties = [String: Any]()

    public init(_ subject: Any?) {
        guard let subject = subject else {
            return
        }

        let mirror = Mirror(reflecting: unwrapOptionalIfPossible(subject))
        readMirror(mirror: mirror)
    }

    /// unwraps value of any if its optional, if not returns initial
    private func unwrapOptionalIfPossible(_ any: Any) -> Any {
        let mirror = Mirror(reflecting: any)
        guard mirror.displayStyle == .optional,
              let (_, value) = mirror.children.first else {
            return any
        }
        return value
    }

    private func readMirror(mirror: Mirror) {
        // read optional value
        for case (let label, let value) in mirror.children {
            // Note ".storage" is appended to lazy var properties
            if let label = label?.replacingOccurrences(of: ".storage", with: "") {
                properties[label] = unwrapOptionalIfPossible(value)
            }
        }
        if let superMirror = mirror.superclassMirror {
            readMirror(mirror: superMirror)
        }
    }

    public func property<T>(named name: String) -> T? {
        return properties[name] as? T
    }

    public func property<T>(_: T.Type, named name: String) -> T? {
        return property(named: name)
    }
}
