import Nimble
import NSpry
import Quick

@testable import NFoundation
@testable import NFoundationTestHelpers

private protocol SomeGenericProtocol {
    init()
}

private class SomeGeneric: SomeGenericProtocol {
    required init() {}
}

private protocol SomeProtocol {}

private class SomeWithProtocol: SomeProtocol {}

private class Some {}

private class Container<T: SomeGenericProtocol> {
    let lsome = Some()
    let lsomeWithProtocol = SomeWithProtocol()
    let lprotocol: SomeProtocol = SomeWithProtocol()
    let lgeneric = T()

    let lsomeOptional: Some? = Some()
    let lsomeWithProtocolOptional: SomeWithProtocol? = SomeWithProtocol()
    let lprotocolOptional: SomeProtocol? = SomeWithProtocol()
    let lgenericOptional: T? = T()

    let lsomeOptionalNil: Some? = nil
    let lsomeWithProtocolOptionalNil: SomeWithProtocol? = nil
    let lprotocolOptionalNil: SomeProtocol? = nil
    let lgenericOptionalNil: T? = nil

    let lsomeImplicitly: Some! = Some()
    let lsomeWithProtocolImplicitly: SomeWithProtocol! = SomeWithProtocol()
    let lprotocolImplicitly: SomeProtocol! = SomeWithProtocol()
    let lgenericImplicitly: T! = T()

    let lsomeImplicitlyNil: Some! = nil
    let lsomeWithProtocolImplicitlyNil: SomeWithProtocol! = nil
    let lprotocolImplicitlyNil: SomeProtocol! = nil
    let lgenericImplicitlyNil: T! = nil

    var vsome = Some()
    var vsomeWithProtocol = SomeWithProtocol()
    var vprotocol: SomeProtocol = SomeWithProtocol()
    var vgeneric = T()

    var vsomeOptional: Some? = Some()
    var vsomeWithProtocolOptional: SomeWithProtocol? = SomeWithProtocol()
    var vprotocolOptional: SomeProtocol? = SomeWithProtocol()
    var vgenericOptional: T? = T()

    var vsomeOptionalNil: Some?
    var vsomeWithProtocolOptionalNil: SomeWithProtocol?
    var vprotocolOptionalNil: SomeProtocol?
    var vgenericOptionalNil: T?

    var vsomeImplicitly: Some! = Some()
    var vsomeWithProtocolImplicitly: SomeWithProtocol! = SomeWithProtocol()
    var vprotocolImplicitly: SomeProtocol! = SomeWithProtocol()
    var vgenericImplicitly: T! = T()

    var vsomeImplicitlyNil: Some!
    var vsomeWithProtocolImplicitlyNil: SomeWithProtocol!
    var vprotocolImplicitlyNil: SomeProtocol!
    var vgenericImplicitlyNil: T!
}

final class PropertyReflectorSpec: QuickSpec {
    override func spec() {
        describe("PropertyReflector") {
            var subject: PropertyReflector!
            beforeEach {
                subject = PropertyReflector(Container<SomeGeneric>())
            }

            context("let") {
                it("requireds should not be nil") {
                    let some: Some? = subject.property(named: "lsome")
                    expect(some).toNot(beNil())

                    let someWithProtocol: SomeWithProtocol? = subject.property(named: "lsomeWithProtocol")
                    expect(someWithProtocol).toNot(beNil())

                    let protocol_: SomeWithProtocol? = subject.property(named: "lprotocol")
                    expect(protocol_).toNot(beNil())

                    let genericProtocol: SomeGenericProtocol? = subject.property(named: "lgeneric")
                    expect(genericProtocol).toNot(beNil())

                    let generic: SomeGeneric? = subject.property(named: "lgeneric")
                    expect(generic).toNot(beNil())
                }

                it("optionals should not be nil") {
                    let some: Some? = subject.property(named: "lsomeOptional")
                    expect(some).toNot(beNil())

                    let someWithProtocol: SomeWithProtocol? = subject.property(named: "lsomeWithProtocolOptional")
                    expect(someWithProtocol).toNot(beNil())

                    let protocol_: SomeWithProtocol? = subject.property(named: "lprotocolOptional")
                    expect(protocol_).toNot(beNil())

                    let genericProtocol: SomeGenericProtocol? = subject.property(named: "lgenericOptional")
                    expect(genericProtocol).toNot(beNil())

                    let generic: SomeGeneric? = subject.property(named: "lgenericOptional")
                    expect(generic).toNot(beNil())
                }

                it("optionals should be nil") {
                    let some: Some? = subject.property(named: "lsomeOptionalNil")
                    expect(some).to(beNil())

                    let someWithProtocol: SomeWithProtocol? = subject.property(named: "lsomeWithProtocolOptionalNil")
                    expect(someWithProtocol).to(beNil())

                    let protocol_: SomeWithProtocol? = subject.property(named: "lprotocolOptionalNil")
                    expect(protocol_).to(beNil())

                    let genericProtocol: SomeGenericProtocol? = subject.property(named: "lgenericOptionalNil")
                    expect(genericProtocol).to(beNil())

                    let generic: SomeGeneric? = subject.property(named: "lgenericOptionalNil")
                    expect(generic).to(beNil())
                }

                it("implicitly unwrapped optionals should not be nil") {
                    let some: Some? = subject.property(named: "lsomeImplicitly")
                    expect(some).toNot(beNil())

                    let someWithProtocol: SomeWithProtocol? = subject.property(named: "lsomeWithProtocolImplicitly")
                    expect(someWithProtocol).toNot(beNil())

                    let protocol_: SomeWithProtocol? = subject.property(named: "lprotocolImplicitly")
                    expect(protocol_).toNot(beNil())

                    let genericProtocol: SomeGenericProtocol? = subject.property(named: "lgenericImplicitly")
                    expect(genericProtocol).toNot(beNil())

                    let generic: SomeGeneric? = subject.property(named: "lgenericImplicitly")
                    expect(generic).toNot(beNil())
                }

                it("implicitly unwrapped optionals should be nil") {
                    let some: Some? = subject.property(named: "lsomeImplicitlyNil")
                    expect(some).to(beNil())

                    let someWithProtocol: SomeWithProtocol? = subject.property(named: "lsomeWithProtocolImplicitlyNil")
                    expect(someWithProtocol).to(beNil())

                    let protocol_: SomeWithProtocol? = subject.property(named: "lprotocolImplicitlyNil")
                    expect(protocol_).to(beNil())

                    let genericProtocol: SomeGenericProtocol? = subject.property(named: "lgenericImplicitlyNil")
                    expect(genericProtocol).to(beNil())

                    let generic: SomeGeneric? = subject.property(named: "lgenericImplicitlyNil")
                    expect(generic).to(beNil())
                }
            }

            context("var") {
                it("requireds should not be nil") {
                    let some: Some? = subject.property(named: "vsome")
                    expect(some).toNot(beNil())

                    let someWithProtocol: SomeWithProtocol? = subject.property(named: "vsomeWithProtocol")
                    expect(someWithProtocol).toNot(beNil())

                    let protocol_: SomeWithProtocol? = subject.property(named: "vprotocol")
                    expect(protocol_).toNot(beNil())

                    let genericProtocol: SomeGenericProtocol? = subject.property(named: "vgeneric")
                    expect(genericProtocol).toNot(beNil())

                    let generic: SomeGeneric? = subject.property(named: "vgeneric")
                    expect(generic).toNot(beNil())
                }

                it("optionals should not be nil") {
                    let some: Some? = subject.property(named: "vsomeOptional")
                    expect(some).toNot(beNil())

                    let someWithProtocol: SomeWithProtocol? = subject.property(named: "vsomeWithProtocolOptional")
                    expect(someWithProtocol).toNot(beNil())

                    let protocol_: SomeWithProtocol? = subject.property(named: "vprotocolOptional")
                    expect(protocol_).toNot(beNil())

                    let genericProtocol: SomeGenericProtocol? = subject.property(named: "vgenericOptional")
                    expect(genericProtocol).toNot(beNil())

                    let generic: SomeGeneric? = subject.property(named: "vgenericOptional")
                    expect(generic).toNot(beNil())
                }

                it("optionals should be nil") {
                    let some: Some? = subject.property(named: "vsomeOptionalNil")
                    expect(some).to(beNil())

                    let someWithProtocol: SomeWithProtocol? = subject.property(named: "vsomeWithProtocolOptionalNil")
                    expect(someWithProtocol).to(beNil())

                    let protocol_: SomeWithProtocol? = subject.property(named: "vprotocolOptionalNil")
                    expect(protocol_).to(beNil())

                    let genericProtocol: SomeGenericProtocol? = subject.property(named: "vgenericOptionalNil")
                    expect(genericProtocol).to(beNil())

                    let generic: SomeGeneric? = subject.property(named: "vgenericOptionalNil")
                    expect(generic).to(beNil())
                }

                it("implicitly unwrapped optionals should not be nil") {
                    let some: Some? = subject.property(named: "vsomeImplicitly")
                    expect(some).toNot(beNil())

                    let someWithProtocol: SomeWithProtocol? = subject.property(named: "vsomeWithProtocolImplicitly")
                    expect(someWithProtocol).toNot(beNil())

                    let protocol_: SomeWithProtocol? = subject.property(named: "vprotocolImplicitly")
                    expect(protocol_).toNot(beNil())

                    let genericProtocol: SomeGenericProtocol? = subject.property(named: "vgenericImplicitly")
                    expect(genericProtocol).toNot(beNil())

                    let generic: SomeGeneric? = subject.property(named: "vgenericImplicitly")
                    expect(generic).toNot(beNil())
                }

                it("implicitly unwrapped optionals should be nil") {
                    let some: Some? = subject.property(named: "vsomeImplicitlyNil")
                    expect(some).to(beNil())

                    let someWithProtocol: SomeWithProtocol? = subject.property(named: "vsomeWithProtocolImplicitlyNil")
                    expect(someWithProtocol).to(beNil())

                    let protocol_: SomeWithProtocol? = subject.property(named: "vprotocolImplicitlyNil")
                    expect(protocol_).to(beNil())

                    let genericProtocol: SomeGenericProtocol? = subject.property(named: "vgenericImplicitlyNil")
                    expect(genericProtocol).to(beNil())

                    let generic: SomeGeneric? = subject.property(named: "vgenericImplicitlyNil")
                    expect(generic).to(beNil())
                }
            }
        }
    }
}
