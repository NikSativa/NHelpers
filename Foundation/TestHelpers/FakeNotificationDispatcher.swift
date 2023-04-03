import Foundation
import NFoundation
import NSpry

public final class FakeNotificationDispatcher: NotificationDispatching, Spryable {
    public enum ClassFunction: String, StringRepresentable {
        case empty
    }

    public enum Function: String, StringRepresentable {
        case addObserverWithBlock = "addObserver(forName:object:queue:using:)"
        case postNotification = "post(_:)"
        case postNotificationName = "post(name:object:userInfo:)"
    }

    public init() {}

    public var addObserverClosure: ((Notification) -> Void)?
    public func addObserver(forName name: Name,
                            object obj: Any?,
                            queue: OperationQueue?,
                            using block: @escaping @Sendable (Notification) -> Void) -> NotificationToken {
        addObserverClosure = block
        return spryify(arguments: name, obj, queue, block)
    }

    public func post(_ notification: Notification) {
        return spryify(arguments: notification)
    }

    public func post(name aName: Name,
                     object anObject: Any?,
                     userInfo aUserInfo: [AnyHashable: Any]?) {
        return spryify(arguments: aName, anObject, aUserInfo)
    }
}
