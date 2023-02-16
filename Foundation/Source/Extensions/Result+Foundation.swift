import Foundation

public extension Result {
    var value: Success? {
        return try? get()
    }

    var error: Failure? {
        switch self {
        case .success:
            return nil
        case .failure(let error):
            return error
        }
    }
}
