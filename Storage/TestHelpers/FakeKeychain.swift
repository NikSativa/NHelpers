import Foundation
import NSpry
import UIKit

@testable import NStorage

final class FakeKeychain: Keychain, Spryable {
    enum ClassFunction: String, StringRepresentable {
        case empty
    }

    enum Function: String, StringRepresentable {
        case readData = "read(dataFor:)"
        case readString = "read(stringFor:)"
        case read = "read(for:)"
        case writeData = "write(dataFor:)"
        case writeString = "write(stringFor:)"
        case write = "write(for:)"

        case clear = "clear()"
        case clearForKey = "clear(for:)"
    }

    func read(dataFor key: String) throws -> Data? {
        return spryify(arguments: key)
    }

    func read<T>(for key: String) throws -> T? where T: Decodable {
        return spryify(arguments: key)
    }

    func read(stringFor key: String) throws -> String? {
        return spryify(arguments: key)
    }

    func write(data: Data, for key: String) throws {
        return spryify(arguments: data, key)
    }

    func write<T>(_ value: T, for key: String) throws where T: Encodable {
        return spryify(arguments: value, key)
    }

    func write(string: String, for key: String) throws {
        return spryify(arguments: string, key)
    }

    func clear() throws {
        return spryify()
    }

    func clear(for key: String) throws {
        return spryify(arguments: key)
    }
}
