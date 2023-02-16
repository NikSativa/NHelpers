import Foundation
import NSpry

#if !canImport(NRequest)
extension URLRequest: SpryEquatable {
    static func testMake(url: URL = .testMake(),
                         headers: [String: String] = [:]) -> URLRequest {
        var request = URLRequest(url: url)
        for (key, value) in headers {
            request.addValue(value, forHTTPHeaderField: key)
        }
        return request
    }
}
#endif
