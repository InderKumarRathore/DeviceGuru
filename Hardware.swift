//
//  Hardware.swift
//  DeviceGuru
//
//  Created by Inder Kumar Rathore on 24/03/16.
//  Copyright © 2016 Inder Kumar Rathore. All rights reserved.
//
//  Hardware string can be found @http://www.everymac.com


/// Enum for different iPhone/iPad devices
public enum Hardware {
  // These are for the new or the devices that are not listed in this lib
  // if you get one of these then please submit an issue here : https://github.com/InderKumarRathore/DeviceGuru
  case unknownIphone
  case unknownIpad
  case unknownIpod
  case unknownAppleWatch
  case unknownAppleTV
  case unknownDevice

  case iphone2g
  case iphone3g
  case iphone3gs

  case iphone4
  case iphone4_cdma
  case iphone4s

  case iphone5
  case iphone5_cdma_gsm
  case iphone5c
  case iphone5c_cdma_gsm
  case iphone5s
  case iphone5s_cdma_gsm

  case iphone6
  case iphone6Plus
  case iphone6s
  case iphone6sPlus
  case iphoneSE

  case iphone7
  case iphone7Plus

  case iphone8
  case iphone8Plus
  case iphoneX

  case ipodTouch1g
  case ipodTouch2g
  case ipodTouch3g
  case ipodTouch4g
  case ipodTouch5g
  case ipodTouch6g

  case ipad
  case ipad2
  case ipad2_wifi
  case ipad2_cdma
  case ipad3
  case ipad3g
  case ipad3_wifi
  case ipad3_wifi_cdma
  case ipad4
  case ipad4_wifi
  case ipad4_gsm_cdma

  case ipadMini
  case ipadMini_wifi
  case ipadMini_wifi_cdma
  case ipadMiniRetina_wifi
  case ipadMiniRetina_wifi_cdma
  case ipadMini3_wifi
  case ipadMini3_wifi_cellular
  case ipadMini3_wifi_cellular_cn
  case ipadMini4_wifi
  case ipadMini4_wifi_cellular
  case ipadMiniRetina_wifi_cellular_cn

  case ipadAir_wifi
  case ipadAir_wifi_gsm
  case ipadAir_wifi_cdma
  case ipadAir2_wifi
  case ipadAir2_wifi_cellular

  case ipadPro_97_wifi
  case ipadPro_97_wifi_cellular
  case ipadPro_wifi
  case ipadPro_wifi_cellular

  case ipad5_wifi
  case ipad5_wifi_cellular

  case ipadPro2g_wifi
  case ipadPro2g_wifi_cellular
  case ipadPro_105_wifi
  case ipadPro_105_wifi_cellular

  case appleTv1g
  case appleTv2g
  case appleTv3g_2012
  case appleTv3g_2013
  case appleTv4g

  case appleWatch_38
  case appleWatch_42
  case appleWatch_series_2_38
  case appleWatch_series_2_42
  case appleWatch_series_1_38
  case appleWatch_series_1_42

  case simulator
}

/// Enum of the different Apple's device platforms
public enum Platform {
    case iPhone
    case iPodTouch
    case iPad
    case appleTV
    case appleWatch
    case unknown
}
