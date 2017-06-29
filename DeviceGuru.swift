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
    sysctl(&name, 2, nil, &size, nil, 0)
    var hw_machine = [CChar](repeating: 0, count: Int(size))
    sysctl(&name, 2, &hw_machine, &size, nil, 0)
    
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
    
    if (hardware == "iPhone1,1")         { return Hardware.iphone_2g }
    if (hardware == "iPhone1,2")         { return Hardware.iphone_3g }
    if (hardware == "iPhone2,1")         { return Hardware.iphone_3gs }
    
    if (hardware == "iPhone3,1")         { return Hardware.iphone_4 }
    if (hardware == "iPhone3,2")         { return Hardware.iphone_4 }
    if (hardware == "iPhone3,3")         { return Hardware.iphone_4_cdma }
    if (hardware == "iPhone4,1")         { return Hardware.iphone_4s }
    
    if (hardware == "iPhone5,1")         { return Hardware.iphone_5 }
    if (hardware == "iPhone5,2")         { return Hardware.iphone_5_cdma_gsm }
    if (hardware == "iPhone5,3")         { return Hardware.iphone_5c }
    if (hardware == "iPhone5,4")         { return Hardware.iphone_5c_cdma_gsm }
    if (hardware == "iPhone6,1")         { return Hardware.iphone_5s }
    if (hardware == "iPhone6,2")         { return Hardware.iphone_5s_cdma_gsm }
    
    if (hardware == "iPhone7,1")         { return Hardware.iphone_6_plus }
    if (hardware == "iPhone7,2")         { return Hardware.iphone_6 }
    if (hardware == "iPhone8,2")         { return Hardware.iphone_6s_plus }
    if (hardware == "iPhone8,1")         { return Hardware.iphone_6s }
    if (hardware == "iPhone8,4")         { return Hardware.iphone_se }
    
    if (hardware == "iPhone9,1")         { return Hardware.iphone_7 }
    if (hardware == "iPhone9,2")         { return Hardware.iphone_7_plus }
    if (hardware == "iPhone9,3")         { return Hardware.iphone_7 }
    if (hardware == "iPhone9,4")         { return Hardware.iphone_7_plus }
    
    if (hardware == "iPod1,1")           { return Hardware.ipod_touch_1g }
    if (hardware == "iPod2,1")           { return Hardware.ipod_touch_2g }
    if (hardware == "iPod3,1")           { return Hardware.ipod_touch_3g }
    if (hardware == "iPod4,1")           { return Hardware.ipod_touch_4g }
    if (hardware == "iPod5,1")           { return Hardware.ipod_touch_5g }
    
    if (hardware == "iPad1,1")           { return Hardware.ipad }
    if (hardware == "iPad1,2")           { return Hardware.ipad_3g }
    if (hardware == "iPad2,1")           { return Hardware.ipad_2_wifi }
    if (hardware == "iPad2,2")           { return Hardware.ipad_2 }
    if (hardware == "iPad2,3")           { return Hardware.ipad_2_cdma }
    if (hardware == "iPad2,4")           { return Hardware.ipad_2 }
    if (hardware == "iPad2,5")           { return Hardware.ipad_mini_wifi }
    if (hardware == "iPad2,6")           { return Hardware.ipad_mini }
    if (hardware == "iPad2,7")           { return Hardware.ipad_mini_wifi_cdma }
    if (hardware == "iPad3,1")           { return Hardware.ipad_3_wifi }
    if (hardware == "iPad3,2")           { return Hardware.ipad_3_wifi_cdma }
    if (hardware == "iPad3,3")           { return Hardware.ipad_3 }
    if (hardware == "iPad3,4")           { return Hardware.ipad_4_wifi }
    if (hardware == "iPad3,5")           { return Hardware.ipad_4 }
    if (hardware == "iPad3,6")           { return Hardware.ipad_4_gsm_cdma }
    if (hardware == "iPad4,1")           { return Hardware.ipad_air_wifi }
    if (hardware == "iPad4,2")           { return Hardware.ipad_air_wifi_gsm }
    if (hardware == "iPad4,3")           { return Hardware.ipad_air_wifi_cdma }
    if (hardware == "iPad4,4")           { return Hardware.ipad_mini_retina_wifi }
    if (hardware == "iPad4,5")           { return Hardware.ipad_mini_retina_wifi_cdma }
    if (hardware == "iPad4,6")           { return Hardware.ipad_mini_retina_wifi_cellular_cn }
    if (hardware == "iPad4,7")           { return Hardware.ipad_mini_3_wifi }
    if (hardware == "iPad4,8")           { return Hardware.ipad_mini_3_wifi_cellular }
    if (hardware == "iPad5,1")           { return Hardware.ipad_mini_4_wifi }
    if (hardware == "iPad5,2")           { return Hardware.ipad_mini_4_wifi_cellular }
    if (hardware == "iPad5,3")           { return Hardware.ipad_air_2_wifi }
    if (hardware == "iPad5,4")           { return Hardware.ipad_air_2_wifi_cellular }
    
    if (hardware == "iPad6,3")           { return Hardware.ipad_pro_97_wifi }
    if (hardware == "iPad6,4")           { return Hardware.ipad_pro_97_wifi_cellular }
    if (hardware == "iPad6,7")           { return Hardware.ipad_pro_wifi }
    if (hardware == "iPad6,8")           { return Hardware.ipad_pro_wifi_cellular }
    
    if (hardware == "iPad6,11")          { return Hardware.ipad_5_wifi }
    if (hardware == "iPad6,12")          { return Hardware.ipad_5_wifi_cellular }
    
    if (hardware == "AppleTV1,1")        { return Hardware.appletv_1g }
    if (hardware == "AppleTV2,1")        { return Hardware.appletv_2g }
    if (hardware == "AppleTV3,1")        { return Hardware.appletv_3g }
    if (hardware == "AppleTV3,2")        { return Hardware.appletv_3_2g }
    if (hardware == "AppleTV5,3")        { return Hardware.appletv_4g }
    
    if (hardware == "Watch1,1")          { return Hardware.appleWatch_38 }
    if (hardware == "Watch1,2")          { return Hardware.appleWatch_42 }
    if (hardware == "Watch2,3")          { return Hardware.appleWatch_series_2_38 }
    if (hardware == "Watch2,4")          { return Hardware.appleWatch_series_2_42 }
    if (hardware == "Watch2,6")          { return Hardware.appleWatch_series_1_38 }
    if (hardware == "Watch2,7")          { return Hardware.appleWatch_series_1_42 }
    
    if (hardware == "i386")              { return Hardware.simulator }
    if (hardware == "x86_64")            { return Hardware.simulator }
    if (hardware.hasPrefix("iPhone"))    { return Hardware.simulator }
    if (hardware.hasPrefix("iPod"))      { return Hardware.simulator }
    if (hardware.hasPrefix("iPad"))      { return Hardware.simulator }
    
    //log message that your device is not present in the list
    logMessage(hardware)
    
    return Hardware.not_AVAILABLE
  }
    
    /// This method returns the Platform enum depending upon harware string
    ///
    ///
    /// - returns: `Platform` type of the device
    ///
    class open func platform() -> Platform {
        
        let hardware = hardwareString().lowercased()
        
        if hardware.hasPrefix(Platform.iPhone.rawValue) { return Platform.iPhone }
        if hardware.hasPrefix(Platform.iPodTouch.rawValue) { return Platform.iPodTouch }
        if hardware.hasPrefix(Platform.iPad.rawValue) { return Platform.iPad }
        if hardware.hasPrefix(Platform.appleTV.rawValue) { return Platform.appleTV }
        if hardware.hasPrefix(Platform.appleWatch.rawValue) { return Platform.appleWatch }
        
        return Platform.unknown
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
      
    case .iphone_4, .iphone_4_cdma, .ipad_3_wifi, .ipad_3_wifi_cdma, .ipad_3, .ipad_4_wifi, .ipad_4, .ipad_4_gsm_cdma:
      return CGSize(width: 2592, height: 1936)
      
    case .iphone_4S, .iphone_5, .iphone_5_cdma_gsm, .iphone_5C, .iphone_5C_cdma_gsm, .iphone_6, .iphone_6_PLUS:
      return CGSize(width: 3264, height: 2448)
      
    case .ipod_TOUCH_4G:
      return CGSize(width: 960, height: 720)
      
    case .ipod_TOUCH_5G:
      return CGSize(width: 2440, height: 1605)
      
    case .ipad_2_wifi, .ipad_2, .ipad_2_cdma:
      return CGSize(width: 872, height: 720)
      
    case .ipad_mini_wifi, .ipad_mini, .ipad_mini_wifi_cdma:
      return CGSize(width: 1820, height: 1304)

    case .ipad_mini_4_wifi, .ipad_mini_4_wifi_cellular:
      return CGSize(width: 3264, height: 2448)

    case .ipad_air_2_wifi, .ipad_air_2_wifi_cellular:
      return CGSize(width: 2048, height: 1536)
    
    case .iphone_6S, .iphone_6S_PLUS, .iphone_SE, .iphone_7, .iphone_7_PLUS:
      return CGSize(width: 4032, height: 3024)
      
    case .ipad_pro_97_wifi, .ipad_pro_97_wifi_cellular:
        return CGSize(width: 4032, height: 3024)
    case .ipad_pro_wifi, .ipad_pro_wifi_cellular:
      return CGSize(width: 3264, height: 2448)
        
    case .ipad_PRO_2G_WIFI, .ipad_PRO_2G_WIFI_CELLULAR, .ipad_PRO_105_WIFI, .ipad_PRO_105_WIFI_CELLULAR:
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
  fileprivate static func logMessage(_ hardware: String) {
    print("This is a device which is not listed in this category. Please visit https://github.com/InderKumarRathore/DeviceGuru and add a comment there.")
    print("Your device hardware string is: %@", hardware)
  }
}


