import Foundation
import NValueEventier

final class UserDefaultsStorage<Value>: Storage
where Value: ExpressibleByNilLiteral & Codable {
    private(set) var eventier: ValueEventier<Value>

    private let defaults: UserDefaults
    private let key: String
    private lazy var decoder: JSONDecoder = .init()
    private lazy var encoder: JSONEncoder = .init()

    init(key: String,
         defaults: UserDefaults) {
        self.key = key
        self.defaults = defaults

        self.eventier = .init(wrappedValue: nil)
        eventier.wrappedValue = get()
    }

    func get() -> Value {
        if let data = defaults.data(forKey: key),
           let result = try? decoder.decode(Value.self, from: data) {
            return result
        }
        return nil
    }

    func set(_ newValue: Value) {
        let result: Value
        if let data = try? encoder.encode(newValue) {
            defaults.set(data, forKey: key)
            result = newValue
        } else {
            defaults.removeObject(forKey: key)
            result = nil
        }

        defaults.synchronize()
        eventier.wrappedValue = result
    }
}
