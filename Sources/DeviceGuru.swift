// Copyright @DeviceGuru

import Foundation

public protocol DeviceGuru {

    /// Version of the library
    static var libraryVersion: String { get }

    /// Returns raw `String` of device type, e.g. iPhone5,1
    var hardwareString: String { get }

    var platform: Platform { get }

    var hardware: Hardware { get }

    /// This method returns the hardware version not actual but logical.
    /// e.g. iPhone5,11 will return `DeviceVersion(major: 5, minor: 11)`
    func deviceVersion() throws -> DeviceVersion

    /// Returns a readable name of the hardware string without including device variants related to wireless or cellular networking.
    func hardwareSimpleDescription() throws -> String

    /// Returns full description of the device
    func hardwareDescription() throws -> String
}

public protocol LocalStorage {
    func setValue(_ value: Any?, forKey key: String)
    func object(forKey defaultName: String) -> Any?
}
