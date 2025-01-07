// Copyright @DeviceGuru

// Hardware string can be found @ https://www.everymac.com

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

    private lazy var hardwareDetail: [String: Any]? = {
        guard let hardwareDetail = loadHardwareDetailFromUserDefaultsIfLatest() else {
            let allDevices = loadAllDeviceDictionaryFromPlist()
            let hardwareDetail = allDevices[_hardwareString] as? [String: Any]
            saveHardwareDetailToUserDefaults(hardwareDetail: hardwareDetail)
            return hardwareDetail
        }
        return hardwareDetail
    }()

    private lazy var _hardwareString: String = {
        hardwareDetailProvider.hardwareString
    }()

    private let localStorage: LocalStorage
    private let hardwareDetailProvider: HardwareDetailProvider
    private let plistPath: String?

    /// Initializes the DeviceGuru
    /// - Parameters:
    ///   - localStorage: Provide any local storage where you want to save data related to the device, by default it uses `UserDefaults`
    ///   - plistPath: Provide plist file path, if passed nil it will search for appropriate bundles and load it for you.
    public init(localStorage: LocalStorage = UserDefaults.standard,
                hardwareDetailProvider: HardwareDetailProvider = HardwareDetailProviderImplementation(),
                plistPath: String? = nil) {
        self.localStorage = localStorage
        self.hardwareDetailProvider = hardwareDetailProvider
        self.plistPath = plistPath
    }

    public var hardwareString: String { _hardwareString }

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
        let simpleName =  regEx.stringByReplacingMatches(in: hardwareDescriptionString,
                                                         options: .init(rawValue: 0),
                                                         range: NSRange(location: 0, length: hardwareDescriptionString.count),
                                                         withTemplate: "")
        return simpleName.trimmingCharacters(in: .whitespaces)
    }

    public func hardwareDescription() throws -> String {
        if let hardwareDescription = hardwareDetail?["name"] as? String {
            return hardwareDescription
        }

        //log message that your device is not present in the list
        logMessage(hardwareString)
        throw DeviceGuruException.deviceNotPresentInThePlist(hardwareString)
    }

    public func deviceVersion() throws -> DeviceVersion {
        guard let versionString = findMatch(for: "[\\d]*,[\\d]*", in: hardwareString),
              let version = getVersion(from: versionString) else {
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
    func logMessage(_ hardware: String) {
        print("""
            This is a device which is not listed in this library. Please visit https://github.com/InderKumarRathore/DeviceGuru and submit the issue there.\n
            Your device hardware string is|\(hardware)|"
            """)
    }
}

// MARK: - Private Static methods

private extension DeviceGuruImplementation {

    func findMatch(for regex: String, in text: String) -> String? {
        do {
            let regex = try NSRegularExpression(pattern: regex)
            let results = regex.matches(in: text, range: NSRange(text.startIndex..., in: text))
            let strings: [String] = results.compactMap {
                guard let range = Range($0.range, in: text) else {
                    print("Unable to create the range for: \(text)")
                    return nil
                }
                return String(text[range])
            }
            return strings.first
        } catch let error {
            print("invalid regex: \(error.localizedDescription)")
            return nil
        }
    }

    func getVersion(from string: String) -> DeviceVersion? {
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

    func saveHardwareDetailToUserDefaults(hardwareDetail: [String: Any]?) {
        localStorage.setValue(Self.libraryVersion, forKey: LocalStorageKeys.deviceGuruVersion)
        localStorage.setValue(hardwareDetail, forKey: LocalStorageKeys.hardwareDetail)
    }

    func loadAllDeviceDictionaryFromPlist() -> [String: AnyObject] {

        if let plistPath = plistPath {
            return loadDeviceDictionary(fromPath: plistPath)
        }

        if let dictionary = loadDeviceDictionaryFromTopBundle() {
            return dictionary
        }

        if let dictionary = loadDeviceDictionaryFromMainBundle() {
            return dictionary
        }

        if let dictionary = loadDeviceDictionaryFromFrameworkBundle() {
            return dictionary
        }

        if let dictionary = loadDeviceDictionaryFromSwiftPackage() {
            return dictionary
        }

        assertionFailure("Unable to find \(Constants.plistFileName).\(Constants.plistFileType)")
        return [:]
    }

    func loadDeviceDictionary(fromPath path: String) -> [String: AnyObject] {
        guard let dictionary = NSDictionary(contentsOfFile: path) as? [String: AnyObject] else {
            assertionFailure("Plist is malformed")
            return [:]
        }
        return dictionary
    }

    func loadDeviceDictionaryFromTopBundle() -> [String: AnyObject]? {
        let topBundle = Bundle(for: type(of: self))

        guard let url = topBundle.url(forResource: "DeviceGuru", withExtension: "bundle"),
              let bundle = Bundle(url: url) else {
                  // Bundle not found
                  return nil
              }

        guard let path = bundle.path(forResource: Constants.plistFileName, ofType: Constants.plistFileType),
              let dictionary = NSDictionary(contentsOfFile: path) as? [String: AnyObject] else {
                  assertionFailure("DeviceList.plist not found in the bundle.")
                  return nil
              }
        return dictionary
    }

    func loadDeviceDictionaryFromFrameworkBundle() -> [String: AnyObject]? {
        let bundle = Bundle(for: type(of: self))

        guard let path = bundle.path(forResource: Constants.plistFileName, ofType: Constants.plistFileType),
              let dictionary = NSDictionary(contentsOfFile: path) as? [String: AnyObject] else {
           return nil
        }

        return dictionary
    }

    func loadDeviceDictionaryFromMainBundle() -> [String: AnyObject]? {
        guard let path = Bundle.main.path(forResource: Constants.plistFileName, ofType: Constants.plistFileType),
              let dictionary = NSDictionary(contentsOfFile: path) as? [String: AnyObject] else {
           return nil
       }

        return dictionary
    }

    func loadDeviceDictionaryFromSwiftPackage() -> [String: AnyObject]? {
#if SWIFT_PACKAGE
        let resource = "DeviceList"
        let type = "plist"
        guard let path = Bundle.module.path(forResource: resource, ofType: type),
              let dictionary = NSDictionary(contentsOfFile: path) as? [String: AnyObject] else {
                  return nil
              }
        return dictionary
#else
        return nil
#endif
    }
}

// Mark:- Private UserDefaults

extension UserDefaults: LocalStorage {}

private enum Constants {
    static let plistFileName = "DeviceList"
    static let plistFileType = "plist"
}
