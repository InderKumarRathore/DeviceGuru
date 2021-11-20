//  Copyright @DeviceGuru

//  Hardware string can be found @ https://www.everymac.com

import Foundation

public enum DeviceGuruException: Error {
    case deviceNotPresentInThePlist(String)
    case unableToCreateDeviceVersion(String)
}

public final class DeviceGuruImplementation: DeviceGuru {

    private enum LocalStorageKeys {
        static let hardwareDetail = "github.com/InderKumarRathore/DeviceGuru.HardwareDetail.Key"
        static let deviceGuruVersion = "github.com/InderKumarRathore/DeviceGuru.Version.Key"
    }

    private static var hardwareDetail: [String: Any]?

    private static let _hardwareString: String = {
        var name: [Int32] = [CTL_HW, HW_MACHINE]
        var size: Int = 2
        sysctl(&name, 2, nil, &size, nil, 0)
        var hw_machine = [CChar](repeating: 0, count: Int(size))
        sysctl(&name, 2, &hw_machine, &size, nil, 0)

        var hardware: String = String(cString: hw_machine)

        // Check for simulator
        if hardware == "x86_64" || hardware == "i386" {
            if let deviceID = ProcessInfo.processInfo.environment["SIMULATOR_MODEL_IDENTIFIER"] {
                hardware = deviceID
            }
        }

        return hardware
    }()

    private let localStorage: LocalStorage

    public init(localStorage: LocalStorage = UserDefaults.standard) {
        self.localStorage = localStorage
        guard let localHardwareDetail = loadHardwareDetailFromUserDefaultsIfLatest() else {
            let allDevices = Self.loadAllDeviceDictionaryFromPlist()
            Self.hardwareDetail = allDevices[Self._hardwareString] as? [String: Any]
            saveHardwareDetailToUserDefaults()
            return
        }
        Self.hardwareDetail = localHardwareDetail
    }

    public var hardwareString: String { Self._hardwareString }

    public var platform: Platform {
        let hardware = hardwareString
        if (hardware.hasPrefix("iPhone"))    { return .iPhone }
        if (hardware.hasPrefix("iPod"))      { return .iPodTouch }
        if (hardware.hasPrefix("iPad"))      { return .iPad }
        if (hardware.hasPrefix("Watch"))     { return .appleWatch }
        if (hardware.hasPrefix("AppleTV"))   { return .appleTV }
        return .unknown
    }

    public func hardwareSimpleDescription() throws -> String {
        let hardwareDescriptionString = try hardwareDescription()
        // this expression matches all strings between round brackets (e.g (Wifi), (GSM)) except the pattern "[0-9]+ Gen"
        let regEx = try NSRegularExpression(pattern: "\\((?![0-9]+ Gen).*\\)", options: .caseInsensitive)
        return  regEx.stringByReplacingMatches(in: hardwareDescriptionString,
                                               options: .init(rawValue: 0),
                                               range: NSRange(location: 0, length: hardwareDescriptionString.count),
                                               withTemplate: "")
    }

    public func hardwareDescription() throws -> String {
        if let hardwareDescription = Self.hardwareDetail?["name"] as? String {
            return hardwareDescription
        }

        //log message that your device is not present in the list
        Self.logMessage(hardwareString)
        throw DeviceGuruException.deviceNotPresentInThePlist(hardwareString)
    }

    public func deviceVersion() throws -> DeviceVersion {
        guard let versionString = Self.findMatch(for: "[\\d]*,[\\d]*", in: hardwareString),
              let version =  Self.getVersion(from: versionString) else {
            print("Can't create Version from: \(hardwareString)")
            print("Please report the above log to: https://github.com/InderKumarRathore/DeviceGuru")
            throw DeviceGuruException.unableToCreateDeviceVersion(hardwareString)
        }
        return version
    }

    /// Internal method for loggin, you don't need this method
    ///
    /// - parameters:
    ///     - hardware: `String` hardware type of the device
    ///
    static func logMessage(_ hardware: String) {
        print("""
            This is a device which is not listed in this library. Please visit https://github.com/InderKumarRathore/DeviceGuru and submit the issue there.\n
            Your device hardware string is|\(hardware)|"
            """)
    }
}

// MARK: - Private Static methods

private extension DeviceGuruImplementation {

    static func findMatch(for regex: String, in text: String) -> String? {
        do {
            let regex = try NSRegularExpression(pattern: regex)
            let results = regex.matches(in: text, range: NSRange(text.startIndex..., in: text))
            return results.compactMap {
                guard let range = Range($0.range, in: text) else {
                    print("Unable to create the range for: \(text)")
                    return nil
                }
                return String(text[range])
            }.first
        } catch let error {
            print("invalid regex: \(error.localizedDescription)")
            return nil
        }
    }

    static func getVersion(from string: String) -> DeviceVersion? {
        let components = string.components(separatedBy: ",")
        guard components.count == 2 else {
            print("Can't create components of string: \(string)")
            return nil
        }
        let majorString = components[0].trimmingCharacters(in: .whitespacesAndNewlines)
        let minorString = components[1].trimmingCharacters(in: .whitespacesAndNewlines)

        guard let major = Int(majorString), let minor = Int(minorString) else {
            print("Can't create major: \(majorString) and  minor: \(minorString)")
            return nil
        }
        return DeviceVersion(major: major, minor: minor)
    }

    func loadHardwareDetailFromUserDefaultsIfLatest() -> [String: Any]? {
        let libraryVersion = localStorage.object(forKey: LocalStorageKeys.deviceGuruVersion) as? String
        guard libraryVersion == Self.libraryVersion else { return nil }
        return localStorage.object(forKey: LocalStorageKeys.hardwareDetail) as? [String: Any]
    }

    func saveHardwareDetailToUserDefaults() {
        localStorage.setValue(Self.libraryVersion, forKey: LocalStorageKeys.deviceGuruVersion)
        localStorage.setValue(Self.hardwareDetail, forKey: LocalStorageKeys.hardwareDetail)
    }

    static func loadAllDeviceDictionaryFromPlist() -> [String: AnyObject] {
        let topBundle = Bundle(for: DeviceGuruImplementation.self)
        let resource = "DeviceList"
        let type = "plist"
        if let url = topBundle.url(forResource: "DeviceGuru", withExtension: "bundle") {
            let bundle = Bundle(url: url)
            if let path = bundle?.path(forResource: resource, ofType: type) {
                return NSDictionary(contentsOfFile: path) as! [String: AnyObject]
            } else {
                // Assert if the plist is not found
                assertionFailure("DeviceList.plist not found in the bundle.")
                return [:]
            }
        } else if let path = topBundle.path(forResource: resource, ofType: type) {
            // falling back to main bundle
            return NSDictionary(contentsOfFile: path) as! [String: AnyObject]
        } else {
            #if SWIFT_PACKAGE
            if let path = Bundle.module.path(forResource: resource, ofType: type) {
                return NSDictionary(contentsOfFile: path) as! [String: AnyObject]
            } else {
                // Assert if the plist is not found
                assertionFailure("DeviceList.plist not found in the bundle.")
                return [:]
            }
            #else
            // Assert if the plist is not found
            assertionFailure("DeviceList.plist not found in the bundle.")
            return [:]
            #endif
        }
    }
}

// Mark:- Private UserDefaults

extension UserDefaults: LocalStorage {}
