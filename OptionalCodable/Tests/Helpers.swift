import Foundation
import NOptionalCodable
import NSpry

@inline(__always)
func subjectAction<T: Decodable>(_ json: [String: Any]) -> T? {
    (try? JSONSerialization.data(withJSONObject: json)).flatMap { data in
        return try? JSONDecoder().decode(T.self, from: data)
    }
}
