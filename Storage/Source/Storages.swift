import Foundation
import NFoundation

public enum Storages {}

public extension Storages {
    static func inMemory<Value>(value: Value) -> AnyStorage<Value> {
        return InMemoryStorage(value: value).toAny()
    }

    static func inMemory<Value>() -> AnyStorage<Value>
    where Value: ExpressibleByNilLiteral {
        return InMemoryStorage().toAny()
    }

    static func userDefaults<Value>(key: String,
                                    defaults: UserDefaults = .standard) -> AnyStorage<Value>
    where Value: ExpressibleByNilLiteral & Codable {
        return UserDefaultsStorage(key: key,
                                   defaults: defaults).toAny()
    }

    static func keychain<Value>(key: String,
                                configuration: KeychainConfiguration) -> AnyStorage<Value>
    where Value: Equatable & Codable & ExpressibleByNilLiteral {
        let keychain = Impl.Keychain(configuration: configuration)
        return KeychainStorage(key: key,
                               keychain: keychain).toAny()
    }

    static func file<Value>(fileName: String,
                            fileManager: FileManager = .default) -> AnyStorage<Value>
    where Value: ExpressibleByNilLiteral & Codable {
        return FileStorage(fileName: fileName,
                           fileManager: fileManager).toAny()
    }
}
