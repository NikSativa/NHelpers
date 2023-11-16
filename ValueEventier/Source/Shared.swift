import Combine
import Foundation

/// open to other framework without importing of Combine
public typealias AnyCancellable = Combine.AnyCancellable

public typealias EventStream<Output> = PassthroughSubject<Output, Never>
public typealias ActionStream = PassthroughSubject<Void, Never>
