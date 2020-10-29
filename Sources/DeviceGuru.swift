//
//  DeviceGuru.swift
//
//  Created by Inder Kumar Rathore on 06/02/15.
//  Copyright (c) 2015. All rights reserved.
//
//  Hardware string can be found @ https://www.everymac.com
//

import Foundation

public enum Platform {
    case iPhone
    case iPodTouch
    case iPad
    case appleWatch
    case appleTV
    case unknown
}

open class DeviceGuru {

    /// Stores the list of the devices from the DeviceList.plist
    private let deviceListDict: [String: AnyObject]

    /// Initialises the DeviceGuru using DeviceList.plist if the plist is not found then it asserts
    public init() {
        // get the bundle of the DeviceUtil if it's main bundle then it returns main bundle
        // if it's DeviceUtil.framework then it returns the DeviceUtil.framework bundle
        let deviceUtilTopBundle = Bundle(for: DeviceGuru.self)
        if let url = deviceUtilTopBundle.url(forResource: "DeviceGuru", withExtension: "bundle") {
            let deviceUtilBundle = Bundle(url: url)
            if let path = deviceUtilBundle?.path(forResource: "DeviceList", ofType: "plist") {
                self.deviceListDict = NSDictionary(contentsOfFile: path) as! [String: AnyObject]
            }
            else {
                // Assert if the plist is not found
                assertionFailure("DevicePlist.plist not found in the bundle.")
                self.deviceListDict = [String: AnyObject]()
            }
        }
        else if let path = deviceUtilTopBundle.path(forResource: "DeviceList", ofType: "plist") {
            // falling back to main bundle
            self.deviceListDict = NSDictionary(contentsOfFile: path) as! [String: AnyObject]
        }
        else {
            // Assert if the plist is not found
            assertionFailure("DevicePlist.plist not found in the bundle.")
            self.deviceListDict = [String: AnyObject]()
        }
    }

    /// This method returns the hardware type
    ///
    ///
    /// - returns: raw `String` of device type
    ///
    public func hardwareString() -> String {
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

    /// This method returns the hardware number not actual but logically.
    /// e.g. if the hardware string is 5,1 then hardware number would be 5.1
    ///
    public func hardwareNumber() -> Float? {
        let hardware = hardwareString()

        let hardwareDetail = self.deviceListDict[hardware] as? [String: AnyObject]
        if let hardwareNumber = hardwareDetail?["version"] as? NSNumber {
            return hardwareNumber.floatValue
        }

        //log message that your device is not present in the list
        logMessage(hardware)

        return nil //device might be new or one of missing device so returning nil
    }

    // MARK: - Private

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

