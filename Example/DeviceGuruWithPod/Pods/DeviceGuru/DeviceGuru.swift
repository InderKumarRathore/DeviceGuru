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

public class DeviceGuru {
  
  /// This method retruns the hardware type
  ///
  ///
  /// - returns: raw `String` of device type
  ///
  class public func hardwareString() -> String {
    var name: [Int32] = [CTL_HW, HW_MACHINE]
    var size: Int = 2
    sysctl(&name, 2, nil, &size, &name, 0)
    var hw_machine = [CChar](count: Int(size), repeatedValue: 0)
    sysctl(&name, 2, &hw_machine, &size, &name, 0)
    
    let hardware: String = String.fromCString(hw_machine)!
    return hardware
  }
  
  private static func getDeviceList() -> [String: AnyObject]? {
    // get the bundle of the DeviceUtil if it's main bundle then it returns main bundle
    // if it's DeviceUtil.framework then it returns the DeviceUtil.framework bundle
    let deviceUtilTopBundle = NSBundle(forClass:DeviceGuru.self)
    if let url = deviceUtilTopBundle.URLForResource("DeviceGuru", withExtension: "bundle") {
      let deviceUtilBundle = NSBundle(URL: url)
      if let path = deviceUtilBundle?.pathForResource("DeviceList", ofType: "plist") {
        return NSDictionary(contentsOfFile: path) as? [String: AnyObject]
      }
    }
    else if let path = deviceUtilTopBundle.pathForResource("DeviceList", ofType: "plist") {
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
  class public func hardware() -> Hardware {
    let hardware = hardwareString()
    
    if (hardware == "iPhone1,1")         { return Hardware.IPHONE_2G }
    if (hardware == "iPhone1,2")         { return Hardware.IPHONE_3G }
    if (hardware == "iPhone2,1")         { return Hardware.IPHONE_3GS }
    
    if (hardware == "iPhone3,1")         { return Hardware.IPHONE_4 }
    if (hardware == "iPhone3,2")         { return Hardware.IPHONE_4 }
    if (hardware == "iPhone3,3")         { return Hardware.IPHONE_4_CDMA }
    if (hardware == "iPhone4,1")         { return Hardware.IPHONE_4S }
    
    if (hardware == "iPhone5,1")         { return Hardware.IPHONE_5 }
    if (hardware == "iPhone5,2")         { return Hardware.IPHONE_5_CDMA_GSM }
    if (hardware == "iPhone5,3")         { return Hardware.IPHONE_5C }
    if (hardware == "iPhone5,4")         { return Hardware.IPHONE_5C_CDMA_GSM }
    if (hardware == "iPhone6,1")         { return Hardware.IPHONE_5S }
    if (hardware == "iPhone6,2")         { return Hardware.IPHONE_5S_CDMA_GSM }
    
    if (hardware == "iPhone7,1")         { return Hardware.IPHONE_6_PLUS }
    if (hardware == "iPhone7,2")         { return Hardware.IPHONE_6 }
    if (hardware == "iPhone8,2")         { return Hardware.IPHONE_6S_PLUS }
    if (hardware == "iPhone8,1")         { return Hardware.IPHONE_6S }
    if (hardware == "iPhone8,4")         { return Hardware.IPHONE_SE }

    
    if (hardware == "iPod1,1")           { return Hardware.IPOD_TOUCH_1G }
    if (hardware == "iPod2,1")           { return Hardware.IPOD_TOUCH_2G }
    if (hardware == "iPod3,1")           { return Hardware.IPOD_TOUCH_3G }
    if (hardware == "iPod4,1")           { return Hardware.IPOD_TOUCH_4G }
    if (hardware == "iPod5,1")           { return Hardware.IPOD_TOUCH_5G }
    
    if (hardware == "iPad1,1")           { return Hardware.IPAD }
    if (hardware == "iPad1,2")           { return Hardware.IPAD_3G }
    if (hardware == "iPad2,1")           { return Hardware.IPAD_2_WIFI }
    if (hardware == "iPad2,2")           { return Hardware.IPAD_2 }
    if (hardware == "iPad2,3")           { return Hardware.IPAD_2_CDMA }
    if (hardware == "iPad2,4")           { return Hardware.IPAD_2 }
    if (hardware == "iPad2,5")           { return Hardware.IPAD_MINI_WIFI }
    if (hardware == "iPad2,6")           { return Hardware.IPAD_MINI }
    if (hardware == "iPad2,7")           { return Hardware.IPAD_MINI_WIFI_CDMA }
    if (hardware == "iPad3,1")           { return Hardware.IPAD_3_WIFI }
    if (hardware == "iPad3,2")           { return Hardware.IPAD_3_WIFI_CDMA }
    if (hardware == "iPad3,3")           { return Hardware.IPAD_3 }
    if (hardware == "iPad3,4")           { return Hardware.IPAD_4_WIFI }
    if (hardware == "iPad3,5")           { return Hardware.IPAD_4 }
    if (hardware == "iPad3,6")           { return Hardware.IPAD_4_GSM_CDMA }
    if (hardware == "iPad4,1")           { return Hardware.IPAD_AIR_WIFI }
    if (hardware == "iPad4,2")           { return Hardware.IPAD_AIR_WIFI_GSM }
    if (hardware == "iPad4,3")           { return Hardware.IPAD_AIR_WIFI_CDMA }
    if (hardware == "iPad4,4")           { return Hardware.IPAD_MINI_RETINA_WIFI }
    if (hardware == "iPad4,5")           { return Hardware.IPAD_MINI_RETINA_WIFI_CDMA }
    if (hardware == "iPad4,6")           { return Hardware.IPAD_MINI_RETINA_WIFI_CELLULAR_CN }
    if (hardware == "iPad4,7")           { return Hardware.IPAD_MINI_3_WIFI }
    if (hardware == "iPad4,8")           { return Hardware.IPAD_MINI_3_WIFI_CELLULAR }
    if (hardware == "iPad5,1")           { return Hardware.IPAD_MINI_4_WIFI }
    if (hardware == "iPad5,2")           { return Hardware.IPAD_MINI_4_WIFI_CELLULAR }
    if (hardware == "iPad5,3")           { return Hardware.IPAD_AIR_2_WIFI }
    if (hardware == "iPad5,4")           { return Hardware.IPAD_AIR_2_WIFI_CELLULAR }
    if (hardware == "iPad6,7")           { return Hardware.IPAD_PRO_WIFI }
    if (hardware == "iPad6,8")           { return Hardware.IPAD_PRO_WIFI_CELLULAR }
    
    if (hardware == "i386")              { return Hardware.SIMULATOR }
    if (hardware == "x86_64")            { return Hardware.SIMULATOR }
    if (hardware.hasPrefix("iPhone"))    { return Hardware.SIMULATOR }
    if (hardware.hasPrefix("iPod"))      { return Hardware.SIMULATOR }
    if (hardware.hasPrefix("iPad"))      { return Hardware.SIMULATOR }
    
    //log message that your device is not present in the list
    logMessage(hardware)
    
    return Hardware.NOT_AVAILABLE
  }
  
  
  /// This method returns the readable description of hardware string
  ///
  /// - returns: readable description `String` of the device
  ///
  class public func hardwareDescription() -> String? {
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
  
  ///
  /// This method returns the hardware number not actual but logically.
  /// e.g. if the hardware string is 5,1 then hardware number would be 5.1
  ///
  class public func hardwareNumber() -> Float {
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
  class public func backCameraStillImageResolutionInPixels(hardware: Hardware) -> CGSize {
    switch (hardware) {
    case Hardware.IPHONE_2G, Hardware.IPHONE_3G:
      return CGSizeMake(1600, 1200)
      
    case Hardware.IPHONE_3GS:
      return CGSizeMake(2048, 1536)
      
    case Hardware.IPHONE_4, Hardware.IPHONE_4_CDMA, Hardware.IPAD_3_WIFI, Hardware.IPAD_3_WIFI_CDMA, Hardware.IPAD_3, Hardware.IPAD_4_WIFI, Hardware.IPAD_4, Hardware.IPAD_4_GSM_CDMA:
      return CGSizeMake(2592, 1936)
      
    case Hardware.IPHONE_4S, Hardware.IPHONE_5, Hardware.IPHONE_5_CDMA_GSM, Hardware.IPHONE_5C, Hardware.IPHONE_5C_CDMA_GSM, Hardware.IPHONE_6, Hardware.IPHONE_6_PLUS:
      return CGSizeMake(3264, 2448)
      
    case Hardware.IPOD_TOUCH_4G:
      return CGSizeMake(960, 720)
      
    case Hardware.IPOD_TOUCH_5G:
      return CGSizeMake(2440, 1605)
      
    case Hardware.IPAD_2_WIFI, Hardware.IPAD_2, Hardware.IPAD_2_CDMA:
      return CGSizeMake(872, 720)
      
    case Hardware.IPAD_MINI_WIFI, Hardware.IPAD_MINI, Hardware.IPAD_MINI_WIFI_CDMA:
      return CGSizeMake(1820, 1304)

    case Hardware.IPAD_MINI_4_WIFI, Hardware.IPAD_MINI_4_WIFI_CELLULAR: 
      return CGSizeMake(2448, 3264)

    case Hardware.IPAD_AIR_2_WIFI, Hardware.IPAD_AIR_2_WIFI_CELLULAR:
      return CGSizeMake(1536, 2048)
    
    case Hardware.IPHONE_6S, Hardware.IPHONE_6S_PLUS, Hardware.IPHONE_SE:
      return CGSizeMake(3024, 4032)
        
    case Hardware.IPAD_PRO_WIFI, Hardware.IPAD_PRO_WIFI_CELLULAR:
      return CGSizeMake(2448, 3264)
 
    default:
      print("We have no resolution for your device's camera listed in this category. Please, make photo with back camera of your device, get its resolution in pixels (via Preview Cmd+I for example) and add a comment to this repository (https://github.com/InderKumarRathore/DeviceGuru) on GitHub.com in format Device = Hpx x Wpx.") }
    print("Your device is: \(hardwareDescription())")
    
    return CGSizeZero
  }
  
  /// Internal method for loggin, you don't need this method
  ///
  /// - parameters:
  ///     - hardware: `String` hardware type of the device
  ///
  private static func logMessage(hardware: String) {
    print("This is a device which is not listed in this category. Please visit https://github.com/InderKumarRathore/DeviceGuru and add a comment there.")
    print("Your device hardware string is: %@", hardware)
  }
}


