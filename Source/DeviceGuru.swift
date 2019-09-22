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
    
    /// This method returns the Hardware enum depending upon hardware string
    ///
    ///
    /// - returns: `Hardware` type of the device
    ///
    public func hardware() -> Hardware {
        return hardware(hardware: hardwareString())
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
    public func baseHardwareDescription() -> String? {
        return hardwareDescription(for: "baseName")
    }
    
    /// This method returns the readable description of hardware string
    ///
    /// - returns: readable description `String` of the device
    ///
    public func hardwareDescription() -> String? {
        return hardwareDescription(for: "name")
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
    
    
    /// This method returns the resolution for still image that can be received
    /// from back camera of the current device. Resolution returned for image oriented landscape right.
    ///
    /// - parameters:
    ///     - hardware: `Hardware` type of the device
    ///
    /// - returns: `CGSize` of the image captured by the device
    ///
    public func backCameraStillImageResolutionInPixels(_ hardware: Hardware) -> CGSize {
        switch (hardware) {
        case .iphone2g, .iphone3g:
            return CGSize(width: 1600, height: 1200)
            
        case .iphone3gs:
            return CGSize(width: 2048, height: 1536)
            
        case .iphone4, .iphone4_cdma, .ipad3_wifi, .ipad3_wifi_cdma, .ipad3, .ipad4_wifi, .ipad4, .ipad4_gsm_cdma:
            return CGSize(width: 2592, height: 1936)
            
        case .iphone4s, .iphone5, .iphone5_cdma_gsm, .iphone5c, .iphone5c_cdma_gsm, .iphone6, .iphone6Plus:
            return CGSize(width: 3264, height: 2448)
            
        case .ipodTouch4g:
            return CGSize(width: 960, height: 720)
            
        case .ipodTouch5g:
            return CGSize(width: 2440, height: 1605)
            
        case .ipad2_wifi, .ipad2, .ipad2_cdma:
            return CGSize(width: 872, height: 720)
            
        case .ipadMini_wifi, .ipadMini, .ipadMini_wifi_cdma:
            return CGSize(width: 1820, height: 1304)
            
        case .ipadMini4_wifi, .ipadMini4_wifi_cellular:
            return CGSize(width: 3264, height: 2448)
            
        case .ipadAir2_wifi, .ipadAir2_wifi_cellular:
            return CGSize(width: 2048, height: 1536)
            
        case .iphone6s, .iphone6sPlus, .iphoneSE, .iphone7, .iphone7Plus:
            return CGSize(width: 4032, height: 3024)
            
        case .ipadPro_97_wifi, .ipadPro_97_wifi_cellular:
            return CGSize(width: 4032, height: 3024)
            
        case .ipadPro_wifi, .ipadPro_wifi_cellular:
            return CGSize(width: 3264, height: 2448)
            
        case .ipadPro2g_wifi, .ipadPro2g_wifi_cellular, .ipadPro_105_wifi, .ipadPro_105_wifi_cellular:
            return CGSize(width: 4032, height: 3024)
            
        default:
            print("We have no resolution for your device's camera listed in this category. Please, take photo with back camera of your device, get its resolution in pixels (via Preview Cmd+I for example) and add a comment to this repository (https://github.com/InderKumarRathore/DeviceGuru) on GitHub.com in format Device = Wpx x Hpx.")
        }
        print("Your device is: \(hardwareDescription() ?? "unknown")")
        
        return CGSize.zero
    }
    
    // MARK: - Private
    
    /// Internal method for loggin, you don't need this method
    ///
    /// - parameters:
    ///     - hardware: `String` hardware type of the device
    ///
    func logMessage(_ hardware: String) {
        print("""
            This is a device which is not listed in this library. Please visit https://github.com/InderKumarRathore/DeviceGuru/issues/new and submit the issue there.\n
            Your device hardware string is|\(hardware)|"
            """)
    }
    
    
    /// Internal method to get the hardware description based on key
    /// Current there are full and base hardware description
    ///
    /// - Parameter key: key present in the plist
    /// - Returns: hardware description based on the key
    private func hardwareDescription(for key: String) -> String? {
        let hardware = hardwareString()
        
        let hardwareDetail = self.deviceListDict[hardware] as? [String: AnyObject]
        if let hardwareDescription = hardwareDetail?[key] {
            return hardwareDescription as? String
        }
        
        //log message that your device is not present in the list
        logMessage(hardware)
        return nil
    }
}
