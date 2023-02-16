import Foundation
import NSpry

@testable import NFoundation

final class FakeNotificationDispatcher: NotificationDispatching, Spryable {
    enum ClassFunction: String, StringRepresentable {
        case empty
    }

    enum Function: String, StringRepresentable {
        case addObserverWithBlock = "addObserver(forName:object:queue:using:)"
        case postNotification = "post(_:)"
        case postNotificationName = "post(name:object:userInfo:)"
    }

    var addObserverClosure: ((Notification) -> Void)?
    func addObserver(forName name: Name,
                     object obj: Any?,
                     queue: OperationQueue?,
                     using block: @escaping @Sendable (Notification) -> Void) -> NotificationToken {
        addObserverClosure = block
        return spryify(arguments: name, obj, queue, block)
    }

    func post(_ notification: Notification) {
        return spryify(arguments: notification)
    }

    func post(name aName: Name,
              object anObject: Any?,
              userInfo aUserInfo: [AnyHashable: Any]?) {
        return spryify(arguments: aName, anObject, aUserInfo)
    }
}
