//
//  DeviceGuru.swift
//
//  Created by Inder Kumar Rathore on 06/02/15.
//  Copyright (c) 2015. All rights reserved.
//
//  Hardware string can be found @ https://www.everymac.com
//

import Foundation

open class DeviceGuru {

    /// Stores the list of the devices from the DeviceList.plist
    private let deviceListDict: [String: AnyObject]

    /// Initialises the DeviceGuru using DeviceList.plist if the plist is not found then it asserts
    public init() {
        // get the bundle of the DeviceGuru if it's main bundle then it returns main bundle
        // if it's DeviceGuru.framework then it returns the DeviceGuru.framework bundle
        let topBundle = Bundle(for: DeviceGuru.self)
        let resource = "DeviceList"
        let type = "plist"
        if let url = topBundle.url(forResource: "DeviceGuru", withExtension: "bundle") {
            let bundle = Bundle(url: url)
            if let path = bundle?.path(forResource: resource, ofType: type) {
                self.deviceListDict = NSDictionary(contentsOfFile: path) as! [String: AnyObject]
            } else {
                // Assert if the plist is not found
                assertionFailure("DeviceList.plist not found in the bundle.")
                self.deviceListDict = [String: AnyObject]()
            }
        } else if let path = topBundle.path(forResource: resource, ofType: type) {
            // falling back to main bundle
            self.deviceListDict = NSDictionary(contentsOfFile: path) as! [String: AnyObject]
        } else {
            #if SWIFT_PACKAGE
            if let path = Bundle.module.path(forResource: resource, ofType: type) {
                self.deviceListDict = NSDictionary(contentsOfFile: path) as! [String: AnyObject]
            } else {
                // Assert if the plist is not found
                assertionFailure("DeviceList.plist not found in the bundle.")
                self.deviceListDict = [String: AnyObject]()
            }
            #else
            // Assert if the plist is not found
            assertionFailure("DeviceList.plist not found in the bundle.")
            self.deviceListDict = [String: AnyObject]()
            #endif
        }
    }

    /// This method returns the hardware type
    ///
    ///
    /// - returns: raw `String` of device type, e.g. iPhone5,1
    ///
    public func hardwareString() -> String {
        var name: [Int32] = [CTL_HW, HW_MACHINE]
        var size: Int = 2
        sysctl(&name, 2, nil, &size, nil, 0)
        var hw_machine = [CChar](repeating: 0, count: Int(size))
        sysctl(&name, 2, &hw_machine, &size, nil, 0)

        var hardware: String = String(cString: hw_machine)

        // Check for simulator
        if hardware == "x86_64" || hardware == "i386" || hardware == "arm64" {
            if let deviceID = ProcessInfo.processInfo.environment["SIMULATOR_MODEL_IDENTIFIER"] {
                hardware = deviceID
            }
        }

        return hardware
    }

    /// This method returns the Platform enum depending upon harware string
    ///
    ///
    /// - returns: `Platform` type of the device
    ///
    public func platform() -> Platform {

        let hardware = hardwareString()

        if (hardware.hasPrefix("iPhone"))    { return .iPhone }
        if (hardware.hasPrefix("iPod"))      { return .iPodTouch }
        if (hardware.hasPrefix("iPad"))      { return .iPad }
        if (hardware.hasPrefix("Watch"))     { return .appleWatch }
        if (hardware.hasPrefix("AppleTV"))   { return .appleTV }

        return .unknown
    }

    /// - Returns: a readable description of the hardware string without including device variants related to wireless or cellular networking.
    public func hardwareSimpleDescription() -> String? {

        guard let hardwareDescription = hardwareDescription() else {
            return nil
        }

        // this expression matches all strings between round brackets (e.g (Wifi), (GSM)) except the pattern "[0-9]+ Gen"
        do {
            let regEx = try NSRegularExpression(pattern: "\\((?![0-9]+ Gen).*\\)", options: .caseInsensitive)
            return  regEx.stringByReplacingMatches(in: hardwareDescription,
                                                   options: .init(rawValue: 0),
                                                   range: NSRange(location: 0, length: hardwareDescription.count),
                                                   withTemplate: "")
        } catch {
            print("Regex not created")
            return nil
        }
    }

    /// This method returns the readable description of hardware string
    ///
    /// - returns: readable description `String` of the device
    ///
    public func hardwareDescription() -> String? {
        let hardware = hardwareString()

        let hardwareDetail = self.deviceListDict[hardware] as? [String: AnyObject]
        if let hardwareDescription = hardwareDetail?["name"] {
            return hardwareDescription as? String
        }

        //log message that your device is not present in the list
        logMessage(hardware)
        return nil
    }

    /// This method returns the hardware version not actual but logical.
    /// e.g. iPhone5,11 will return `DeviceVersion(major: 5, minor: 11)`
    ///
    public func deviceVersion() -> DeviceVersion? {
        let hardware = hardwareString()
        guard let versionString = findMatch(for: "[\\d]*,[\\d]*", in: hardware),
              let version =  getVersion(from: versionString) else {
            print("Can't create Version from: \(hardware)")
            print("Please repor the above log to: https://github.com/InderKumarRathore/DeviceGuru")
            return nil
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

// MARK: - Private

private extension DeviceGuru {

    func findMatch(for regex: String, in text: String) -> String? {
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

}
