import Foundation

public typealias VoidClosure = () -> Void
public typealias SetClosure<T> = (T) -> Void
public typealias GetClosure<T> = () -> T
public typealias MapClosure<T, U> = (T) -> U
