import Foundation
import NSpry

#if !canImport(NRequest)
extension URL: SpryEquatable {
    static func testMake(_ string: String = "http://www.some.com") -> URL {
        return URL(string: string)!
    }
}
#endif
