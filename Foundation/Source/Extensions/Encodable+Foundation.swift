import Foundation

public extension Encodable {
    func prettyJsonString() -> String? {
        let encoder = JSONEncoder()
        encoder.outputFormatting = [.prettyPrinted, .sortedKeys]
        if let data = try? encoder.encode(self) {
            return String(data: data, encoding: .utf8)
        }
        return nil
    }
}
