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
  
  /// This method returns the hardware type
  ///
  ///
  /// - returns: raw `String` of device type
  ///
  class open func hardwareString() -> String {
    var name: [Int32] = [CTL_HW, HW_MACHINE]
    var size: Int = 2
    sysctl(&name, 2, nil, &size, &name, 0)
    var hw_machine = [CChar](repeating: 0, count: Int(size))
    sysctl(&name, 2, &hw_machine, &size, &name, 0)
    
    let hardware: String = String(cString: hw_machine)
    return hardware
  }
  
  fileprivate static func getDeviceList() -> [String: AnyObject]? {
    // get the bundle of the DeviceUtil if it's main bundle then it returns main bundle
    // if it's DeviceUtil.framework then it returns the DeviceUtil.framework bundle
    let deviceUtilTopBundle = Bundle(for:DeviceGuru.self)
    if let url = deviceUtilTopBundle.url(forResource: "DeviceGuru", withExtension: "bundle") {
      let deviceUtilBundle = Bundle(url: url)
      if let path = deviceUtilBundle?.path(forResource: "DeviceList", ofType: "plist") {
        return NSDictionary(contentsOfFile: path) as? [String: AnyObject]
      }
    }
    else if let path = deviceUtilTopBundle.path(forResource: "DeviceList", ofType: "plist") {
        // falling back to main bundle
        return NSDictionary(contentsOfFile: path) as? [String: AnyObject]
    }
    assertionFailure("DevicePlist.plist not found in the bundle.")
    return nil
  }
  
  /// This method returns the Hardware enum depending upon harware string
  ///
  ///
  /// - returns: `Hardware` type of the device
  ///
  class open func hardware() -> Hardware {
    let hardware = hardwareString()
    
    if (hardware == "iPhone1,1")         { return Hardware.iphone_2G }
    if (hardware == "iPhone1,2")         { return Hardware.iphone_3G }
    if (hardware == "iPhone2,1")         { return Hardware.iphone_3GS }
    
    if (hardware == "iPhone3,1")         { return Hardware.iphone_4 }
    if (hardware == "iPhone3,2")         { return Hardware.iphone_4 }
    if (hardware == "iPhone3,3")         { return Hardware.iphone_4_CDMA }
    if (hardware == "iPhone4,1")         { return Hardware.iphone_4S }
    
    if (hardware == "iPhone5,1")         { return Hardware.iphone_5 }
    if (hardware == "iPhone5,2")         { return Hardware.iphone_5_CDMA_GSM }
    if (hardware == "iPhone5,3")         { return Hardware.iphone_5C }
    if (hardware == "iPhone5,4")         { return Hardware.iphone_5C_CDMA_GSM }
    if (hardware == "iPhone6,1")         { return Hardware.iphone_5S }
    if (hardware == "iPhone6,2")         { return Hardware.iphone_5S_CDMA_GSM }
    
    if (hardware == "iPhone7,1")         { return Hardware.iphone_6_PLUS }
    if (hardware == "iPhone7,2")         { return Hardware.iphone_6 }
    if (hardware == "iPhone8,2")         { return Hardware.iphone_6S_PLUS }
    if (hardware == "iPhone8,1")         { return Hardware.iphone_6S }
    if (hardware == "iPhone8,4")         { return Hardware.iphone_SE }
    
    if (hardware == "iPhone9,1")         { return Hardware.iphone_7 }
    if (hardware == "iPhone9,2")         { return Hardware.iphone_7_PLUS }
    if (hardware == "iPhone9,3")         { return Hardware.iphone_7 }
    if (hardware == "iPhone9,4")         { return Hardware.iphone_7_PLUS }
    
    if (hardware == "iPod1,1")           { return Hardware.ipod_TOUCH_1G }
    if (hardware == "iPod2,1")           { return Hardware.ipod_TOUCH_2G }
    if (hardware == "iPod3,1")           { return Hardware.ipod_TOUCH_3G }
    if (hardware == "iPod4,1")           { return Hardware.ipod_TOUCH_4G }
    if (hardware == "iPod5,1")           { return Hardware.ipod_TOUCH_5G }
    
    if (hardware == "iPad1,1")           { return Hardware.ipad }
    if (hardware == "iPad1,2")           { return Hardware.ipad_3G }
    if (hardware == "iPad2,1")           { return Hardware.ipad_2_WIFI }
    if (hardware == "iPad2,2")           { return Hardware.ipad_2 }
    if (hardware == "iPad2,3")           { return Hardware.ipad_2_CDMA }
    if (hardware == "iPad2,4")           { return Hardware.ipad_2 }
    if (hardware == "iPad2,5")           { return Hardware.ipad_MINI_WIFI }
    if (hardware == "iPad2,6")           { return Hardware.ipad_MINI }
    if (hardware == "iPad2,7")           { return Hardware.ipad_MINI_WIFI_CDMA }
    if (hardware == "iPad3,1")           { return Hardware.ipad_3_WIFI }
    if (hardware == "iPad3,2")           { return Hardware.ipad_3_WIFI_CDMA }
    if (hardware == "iPad3,3")           { return Hardware.ipad_3 }
    if (hardware == "iPad3,4")           { return Hardware.ipad_4_WIFI }
    if (hardware == "iPad3,5")           { return Hardware.ipad_4 }
    if (hardware == "iPad3,6")           { return Hardware.ipad_4_GSM_CDMA }
    if (hardware == "iPad4,1")           { return Hardware.ipad_AIR_WIFI }
    if (hardware == "iPad4,2")           { return Hardware.ipad_AIR_WIFI_GSM }
    if (hardware == "iPad4,3")           { return Hardware.ipad_AIR_WIFI_CDMA }
    if (hardware == "iPad4,4")           { return Hardware.ipad_MINI_RETINA_WIFI }
    if (hardware == "iPad4,5")           { return Hardware.ipad_MINI_RETINA_WIFI_CDMA }
    if (hardware == "iPad4,6")           { return Hardware.ipad_MINI_RETINA_WIFI_CELLULAR_CN }
    if (hardware == "iPad4,7")           { return Hardware.ipad_MINI_3_WIFI }
    if (hardware == "iPad4,8")           { return Hardware.ipad_MINI_3_WIFI_CELLULAR }
    if (hardware == "iPad5,1")           { return Hardware.ipad_MINI_4_WIFI }
    if (hardware == "iPad5,2")           { return Hardware.ipad_MINI_4_WIFI_CELLULAR }
    if (hardware == "iPad5,3")           { return Hardware.ipad_AIR_2_WIFI }
    if (hardware == "iPad5,4")           { return Hardware.ipad_AIR_2_WIFI_CELLULAR }
    
    if (hardware == "iPad6,3")           { return Hardware.ipad_PRO_97_WIFI }
    if (hardware == "iPad6,4")           { return Hardware.ipad_PRO_97_WIFI_CELLULAR }
    if (hardware == "iPad6,7")           { return Hardware.ipad_PRO_WIFI }
    if (hardware == "iPad6,8")           { return Hardware.ipad_PRO_WIFI_CELLULAR }
    
    if (hardware == "iPad6,11")          { return Hardware.ipad_2017_WIFI }
    if (hardware == "iPad6,12")          { return Hardware.ipad_2017_WIFI_CELLULAR }
    
    if (hardware == "AppleTV1,1")        { return Hardware.appleTV_1G }
    if (hardware == "AppleTV2,1")        { return Hardware.appleTV_2G }
    if (hardware == "AppleTV3,1")        { return Hardware.appleTV_3G }
    if (hardware == "AppleTV3,2")        { return Hardware.appleTV_3_2G }
    if (hardware == "AppleTV5,3")        { return Hardware.appleTV_4G }
    
    if (hardware == "Watch1,1")          { return Hardware.appleWatch_38 }
    if (hardware == "Watch1,2")          { return Hardware.appleWatch_42 }
    if (hardware == "Watch2,3")          { return Hardware.appleWatch_SERIES_2_38 }
    if (hardware == "Watch2,4")          { return Hardware.appleWatch_SERIES_2_42 }
    if (hardware == "Watch2,6")          { return Hardware.appleWatch_SERIES_1_38 }
    if (hardware == "Watch2,7")          { return Hardware.appleWatch_SERIES_1_42 }
    
    if (hardware == "i386")              { return Hardware.simulator }
    if (hardware == "x86_64")            { return Hardware.simulator }
    if (hardware.hasPrefix("iPhone"))    { return Hardware.simulator }
    if (hardware.hasPrefix("iPod"))      { return Hardware.simulator }
    if (hardware.hasPrefix("iPad"))      { return Hardware.simulator }
    
    //log message that your device is not present in the list
    logMessage(hardware)
    
    return Hardware.not_AVAILABLE
  }
  
  
  /// This method returns the readable description of hardware string
  ///
  /// - returns: readable description `String` of the device
  ///
  class open func hardwareDescription() -> String? {
    let hardware = hardwareString()
    if let deviceList = getDeviceList() {
      let hardwareDetail = deviceList[hardware] as? [String: AnyObject]
      if let hardwareDescription = hardwareDetail?["name"] {
        return hardwareDescription as? String
      }
    }
    
    //log message that your device is not present in the list
    logMessage(hardware)
    return nil
  }
  
  /// This method returns the hardware number not actual but logically.
  /// e.g. if the hardware string is 5,1 then hardware number would be 5.1
  ///
  class open func hardwareNumber() -> Float {
    let hardware = hardwareString()
    if let deviceList = getDeviceList() {
      let hardwareDetail = deviceList[hardware] as? [String: AnyObject]
      if let hardwareNumber = hardwareDetail?["version"] as? Float {
        return hardwareNumber
      }
    }
    
    //log message that your device is not present in the list
    logMessage(hardware)
    
    return 200.0 //device might be new one of missing one so returning 200.0f
  }
  
  
  /// This method returns the resolution for still image that can be received
  /// from back camera of the current device. Resolution returned for image oriented landscape right.
  ///
  /// - parameters:
  ///     - hardware: `Hardware` type of the device
  ///
  /// - returns: `CGSize` of the image captured by the device
  ///
  class open func backCameraStillImageResolutionInPixels(_ hardware: Hardware) -> CGSize {
    switch (hardware) {
    case .iphone_2G, .iphone_3G:
      return CGSize(width: 1600, height: 1200)
      
    case .iphone_3GS:
      return CGSize(width: 2048, height: 1536)
      
    case .iphone_4, .iphone_4_CDMA, .ipad_3_WIFI, .ipad_3_WIFI_CDMA, .ipad_3, .ipad_4_WIFI, .ipad_4, .ipad_4_GSM_CDMA:
      return CGSize(width: 2592, height: 1936)
      
    case .iphone_4S, .iphone_5, .iphone_5_CDMA_GSM, .iphone_5C, .iphone_5C_CDMA_GSM, .iphone_6, .iphone_6_PLUS:
      return CGSize(width: 3264, height: 2448)
      
    case .ipod_TOUCH_4G:
      return CGSize(width: 960, height: 720)
      
    case .ipod_TOUCH_5G:
      return CGSize(width: 2440, height: 1605)
      
    case .ipad_2_WIFI, .ipad_2, .ipad_2_CDMA:
      return CGSize(width: 872, height: 720)
      
    case .ipad_MINI_WIFI, .ipad_MINI, .ipad_MINI_WIFI_CDMA:
      return CGSize(width: 1820, height: 1304)

    case .ipad_MINI_4_WIFI, .ipad_MINI_4_WIFI_CELLULAR:
      return CGSize(width: 3264, height: 2448)

    case .ipad_AIR_2_WIFI, .ipad_AIR_2_WIFI_CELLULAR:
      return CGSize(width: 2048, height: 1536)
    
    case .iphone_6S, .iphone_6S_PLUS, .iphone_SE, .iphone_7, .iphone_7_PLUS:
      return CGSize(width: 4032, height: 3024)
      
    case .ipad_PRO_97_WIFI, .ipad_PRO_97_WIFI_CELLULAR:
        return CGSize(width: 4032, height: 3024)
    case .ipad_PRO_WIFI, .ipad_PRO_WIFI_CELLULAR:
      return CGSize(width: 3264, height: 2448)
 
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
  fileprivate static func logMessage(_ hardware: String) {
    print("This is a device which is not listed in this category. Please visit https://github.com/InderKumarRathore/DeviceGuru and add a comment there.")
    print("Your device hardware string is: %@", hardware)
  }
}


