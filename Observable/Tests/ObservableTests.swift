import Foundation
import XCTest

import NObservable

final class ObservableTests: XCTestCase {
    let subject: Observable<FakeState> = .init(wrappedValue: .init(counter: -1, toggle: false))
    var observers: Set<AnyCancellable> = []
    var rootStates: [FakeState] = []

    override func setUp() {
        super.setUp()
        subject.sink { [unowned self] state in
            rootStates.append(state)
        }.store(in: &observers)
    }

    func testShouldFireSubscriptionImmediately() {
        let expected: [FakeState] = [
            .init(counter: -1, toggle: false)
        ]
        XCTAssertEqual(rootStates, expected)
    }

    func testShouldFireSubscriptionOnAnyChanges() {
        subject.wrappedValue.toggle.toggle()
        subject.wrappedValue.counter += 1
        subject.wrappedValue.counter += 1

        let expected: [FakeState] = [
            .init(counter: -1, toggle: false),
            .init(counter: -1, toggle: true),
            .init(counter: 0, toggle: true),
            .init(counter: 1, toggle: true)
        ]
        XCTAssertEqual(rootStates, expected)
    }

    func testShouldFireSubscriptionForKeyPath() {
        var newStates: [Int] = []

        let newSubject = subject.observe(keyPath: \.counter)
        newSubject.sink { state in
            newStates.append(state)
        }.store(in: &observers)

        subject.wrappedValue.toggle.toggle()
        subject.wrappedValue.counter += 1
        subject.wrappedValue.counter += 1

        newSubject.wrappedValue = 2
        newSubject.wrappedValue = 3

        let expectedRootStates: [FakeState] = [
            .init(counter: -1, toggle: false),
            .init(counter: -1, toggle: true),
            .init(counter: 0, toggle: true),
            .init(counter: 1, toggle: true),
            .init(counter: 2, toggle: true),
            .init(counter: 3, toggle: true)
        ]
        XCTAssertEqual(rootStates, expectedRootStates)

        let expectedStates: [Int] = [
            -1,
            -1,
            0,
            1,
            2,
            3
        ]
        XCTAssertEqual(newStates, expectedStates)
        XCTAssertEqual(newSubject.wrappedValue, subject.wrappedValue.counter)
    }
}

// MARK: - ObservableTests.FakeState

extension ObservableTests {
    struct FakeState: Equatable {
        var counter: Int
        var toggle: Bool
    }
}
