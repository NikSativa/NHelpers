import Foundation
import UIKit

#if !canImport(NInject)
extension UIView {
    func resolveDependencies() {
        // overriding NInject behavior
    }
}

extension UIViewController {
    func resolveDependencies() {
        // overriding NInject behavior
    }
}

#endif
