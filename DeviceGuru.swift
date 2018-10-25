//
//  DeviceGuru.swift
//
//  Created by Inder Kumar Rathore on 06/02/15.
//  Copyright (c) 2015. All rights reserved.
//
//  Hardware string can be found @http://www.everymac.com
//

import Foundation
import UIKit

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

  /// This method returns the Hardware enum depending upon harware string
  ///
  ///
  /// - returns: `Hardware` type of the device
  ///
  public func hardware() -> Hardware {
    let hardware = hardwareString()

    if (hardware == "iPhone1,1")  { return .iphone2g }
    if (hardware == "iPhone1,2")  { return .iphone3g }
    if (hardware == "iPhone2,1")  { return .iphone3gs }

    if (hardware == "iPhone3,1")  { return .iphone4 }
    if (hardware == "iPhone3,2")  { return .iphone4 }
    if (hardware == "iPhone3,3")  { return .iphone4_cdma }
    if (hardware == "iPhone4,1")  { return .iphone4s }

    if (hardware == "iPhone5,1")  { return .iphone5 }
    if (hardware == "iPhone5,2")  { return .iphone5_cdma_gsm }
    if (hardware == "iPhone5,3")  { return .iphone5c }
    if (hardware == "iPhone5,4")  { return .iphone5c_cdma_gsm }
    if (hardware == "iPhone6,1")  { return .iphone5s }
    if (hardware == "iPhone6,2")  { return .iphone5s_cdma_gsm }

    if (hardware == "iPhone7,1")  { return .iphone6Plus }
    if (hardware == "iPhone7,2")  { return .iphone6 }
    if (hardware == "iPhone8,1")  { return .iphone6s }
    if (hardware == "iPhone8,2")  { return .iphone6sPlus }
    if (hardware == "iPhone8,4")  { return .iphoneSE }

    if (hardware == "iPhone9,1")  { return .iphone7 }
    if (hardware == "iPhone9,2")  { return .iphone7Plus }
    if (hardware == "iPhone9,3")  { return .iphone7 }
    if (hardware == "iPhone9,4")  { return .iphone7Plus }

    if (hardware == "iPhone10,1")  { return .iphone8 }
    if (hardware == "iPhone10,2")  { return .iphone8Plus }
    if (hardware == "iPhone10,3")  { return .iphoneX }
    if (hardware == "iPhone10,4")  { return .iphone8 }
    if (hardware == "iPhone10,5")  { return .iphone8Plus }
    if (hardware == "iPhone10,6")  { return .iphoneX }

    if (hardware == "iPhone11,2")  { return .iphoneXS }
    if (hardware == "iPhone11,4")  { return .iphoneXSMax }
    if (hardware == "iPhone11,6")  { return .iphoneXSMaxChina }
    if (hardware == "iPhone11,8")  { return .iphoneXR }

    if (hardware == "iPod1,1")    { return .ipodTouch1g }
    if (hardware == "iPod2,1")    { return .ipodTouch2g }
    if (hardware == "iPod3,1")    { return .ipodTouch3g }
    if (hardware == "iPod4,1")    { return .ipodTouch4g }
    if (hardware == "iPod5,1")    { return .ipodTouch5g }
    if (hardware == "iPod7,1")    { return .ipodTouch6g }

    if (hardware == "iPad1,1")    { return .ipad }
    if (hardware == "iPad1,2")    { return .ipad3g }

    if (hardware == "iPad2,1")    { return .ipad2_wifi }
    if (hardware == "iPad2,2")    { return .ipad2 }
    if (hardware == "iPad2,3")    { return .ipad2_cdma }
    if (hardware == "iPad2,4")    { return .ipad2 }
    if (hardware == "iPad2,5")    { return .ipadMini_wifi }
    if (hardware == "iPad2,6")    { return .ipadMini }
    if (hardware == "iPad2,7")    { return .ipadMini_wifi_cdma }

    if (hardware == "iPad3,1")    { return .ipad3_wifi }
    if (hardware == "iPad3,2")    { return .ipad3_wifi_cdma }
    if (hardware == "iPad3,3")    { return .ipad3 }
    if (hardware == "iPad3,4")    { return .ipad4_wifi }
    if (hardware == "iPad3,5")    { return .ipad4 }
    if (hardware == "iPad3,6")    { return .ipad4_gsm_cdma }

    if (hardware == "iPad4,1")    { return .ipadAir_wifi }
    if (hardware == "iPad4,2")    { return .ipadAir_wifi_gsm }
    if (hardware == "iPad4,3")    { return .ipadAir_wifi_cdma }
    if (hardware == "iPad4,4")    { return .ipadMiniRetina_wifi }
    if (hardware == "iPad4,5")    { return .ipadMiniRetina_wifi_cdma }
    if (hardware == "iPad4,6")    { return .ipadMiniRetina_wifi_cellular_cn }
    if (hardware == "iPad4,7")    { return .ipadMini3_wifi }
    if (hardware == "iPad4,8")    { return .ipadMini3_wifi_cellular }
    if (hardware == "iPad4,9")    { return .ipadMini3_wifi_cellular_cn }

    if (hardware == "iPad5,1")    { return .ipadMini4_wifi }
    if (hardware == "iPad5,2")    { return .ipadMini4_wifi_cellular }
    if (hardware == "iPad5,3")    { return .ipadAir2_wifi }
    if (hardware == "iPad5,4")    { return .ipadAir2_wifi_cellular }

    if (hardware == "iPad6,3")    { return .ipadPro_97_wifi }
    if (hardware == "iPad6,4")    { return .ipadPro_97_wifi_cellular }
    if (hardware == "iPad6,7")    { return .ipadPro_wifi }
    if (hardware == "iPad6,8")    { return .ipadPro_wifi_cellular }
    if (hardware == "iPad6,11")   { return .ipad5_wifi }
    if (hardware == "iPad6,12")   { return .ipad5_wifi_cellular }

    if (hardware == "iPad7,1")    { return .ipadPro2g_wifi }
    if (hardware == "iPad7,2")    { return .ipadPro2g_wifi_cellular }
    if (hardware == "iPad7,3")    { return .ipadPro_105_wifi }
    if (hardware == "iPad7,4")    { return .ipadPro_105_wifi_cellular }
    if (hardware == "iPad7,5")    { return .ipad6_wifi }
    if (hardware == "iPad7,6")    { return .ipad6_wifi_cellular }

    if (hardware == "AppleTV1,1")  { return .appleTv1g }
    if (hardware == "AppleTV2,1")  { return .appleTv2g }
    if (hardware == "AppleTV3,1")  { return .appleTv3g_2012 }
    if (hardware == "AppleTV3,2")  { return .appleTv3g_2013 }
    if (hardware == "AppleTV5,3")  { return .appleTv4g }

    if (hardware == "Watch1,1")   { return .appleWatch_38 }
    if (hardware == "Watch1,2")   { return .appleWatch_42 }
    if (hardware == "Watch2,3")   { return .appleWatch_series_2_38 }
    if (hardware == "Watch2,4")   { return .appleWatch_series_2_42 }
    if (hardware == "Watch2,6")   { return .appleWatch_series_1_38 }
    if (hardware == "Watch2,7")   { return .appleWatch_series_1_42 }
    if (hardware == "Watch3,1")   { return .appleWatch_series_3_38_cellular }
    if (hardware == "Watch3,2")   { return .appleWatch_series_3_42_cellular }
    if (hardware == "Watch3,3")   { return .appleWatch_series_3_38 }
    if (hardware == "Watch3,4")   { return .appleWatch_series_3_42 }
    if (hardware == "Watch4,1")   { return .appleWatch_series_4_40 }
    if (hardware == "Watch4,2")   { return .appleWatch_series_4_44 }
    if (hardware == "Watch4,3")   { return .appleWatch_series_4_40_cellular}
    if (hardware == "Watch4,4")   { return .appleWatch_series_4_44_cellular};

    if (hardware == "i386")       { return .simulator }
    if (hardware == "x86_64")     { return .simulator }

    //log message that your device is not present in the list
    logMessage(hardware)
    if (hardware.hasPrefix("iPhone"))  { return .unknownIphone }
    if (hardware.hasPrefix("iPod"))    { return .unknownIpod }
    if (hardware.hasPrefix("iPad"))    { return .unknownIpad }
    if (hardware.hasPrefix("Watch"))   { return .unknownAppleWatch }
    if (hardware.hasPrefix("AppleTV")) { return .unknownAppleTV }

    return .unknownDevice
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

  /// Internal method for loggin, you don't need this method
  ///
  /// - parameters:
  ///     - hardware: `String` hardware type of the device
  ///
  private func logMessage(_ hardware: String) {
    print("""
  This is a device which is not listed in this library. Please visit https://github.com/InderKumarRathore/DeviceGuru/issues/new and submit the issue there.\n
    Your device hardware string is|\(hardware)|"
""")
  }
}
