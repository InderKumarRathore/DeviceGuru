
public extension DeviceGuru {
    /// This method returns the Hardware enum depending upon hardware string
    ///
    ///
    /// - returns: `Hardware` type of the device
    ///
    func hardware() -> Hardware {
        let hardware = hardwareString()

        if (hardware == "AppleTV1,1") { return .apple_tv_1g }
        if (hardware == "AppleTV2,1") { return .apple_tv_2g }
        if (hardware == "AppleTV3,1") { return .apple_tv_3g }
        if (hardware == "AppleTV3,2") { return .apple_tv_3_2g }
        if (hardware == "AppleTV5,3") { return .apple_tv_4g }
        if (hardware == "AppleTV6,2") { return .apple_tv_4k }
        if (hardware == "Watch1,1") { return .apple_watch_38 }
        if (hardware == "Watch1,2") { return .apple_watch_42 }
        if (hardware == "Watch2,3") { return .apple_watch_series_2_38 }
        if (hardware == "Watch2,4") { return .apple_watch_series_2_42 }
        if (hardware == "Watch2,6") { return .apple_watch_series_1_38 }
        if (hardware == "Watch2,7") { return .apple_watch_series_1_42 }
        if (hardware == "Watch3,1") { return .apple_watch_series_3_38_cellular }
        if (hardware == "Watch3,2") { return .apple_watch_series_3_42_cellular }
        if (hardware == "Watch3,3") { return .apple_watch_series_3_38 }
        if (hardware == "Watch3,4") { return .apple_watch_series_3_42 }
        if (hardware == "Watch4,1") { return .apple_watch_series_4_40 }
        if (hardware == "Watch4,2") { return .apple_watch_series_4_44 }
        if (hardware == "Watch4,3") { return .apple_watch_series_4_40_cellular }
        if (hardware == "Watch4,4") { return .apple_watch_series_4_44_cellular }
        if (hardware == "Watch5,1") { return .apple_watch_series_5_40 }
        if (hardware == "Watch5,2") { return .apple_watch_series_5_44 }
        if (hardware == "Watch5,3") { return .apple_watch_series_5_40_cellular }
        if (hardware == "Watch5,4") { return .apple_watch_series_5_44_cellular }
        if (hardware == "i386") { return .simulator }
        if (hardware == "iPad1,1") { return .iPad }
        if (hardware == "iPad1,2") { return .ipad_3g }
        if (hardware == "iPad11,1") { return .ipad_mini_5_wifi }
        if (hardware == "iPad11,2") { return .ipad_mini_5_wifi_cellular }
        if (hardware == "iPad11,3") { return .ipad_air_3_wifi }
        if (hardware == "iPad11,4") { return .ipad_air_3_wifi_cellular }
        if (hardware == "iPad2,1") { return .ipad_2_wifi }
        if (hardware == "iPad2,2") { return .ipad_2 }
        if (hardware == "iPad2,3") { return .ipad_2_cdma }
        if (hardware == "iPad2,4") { return .ipad_2 }
        if (hardware == "iPad2,5") { return .ipad_mini_wifi }
        if (hardware == "iPad2,6") { return .ipad_mini }
        if (hardware == "iPad2,7") { return .ipad_mini_wifi_cdma }
        if (hardware == "iPad3,1") { return .ipad_3_wifi }
        if (hardware == "iPad3,2") { return .ipad_3_wifi_cdma }
        if (hardware == "iPad3,3") { return .ipad_3 }
        if (hardware == "iPad3,4") { return .ipad_4_wifi }
        if (hardware == "iPad3,5") { return .ipad_4 }
        if (hardware == "iPad3,6") { return .ipad_4_gsm_cdma }
        if (hardware == "iPad4,1") { return .ipad_air_wifi }
        if (hardware == "iPad4,2") { return .ipad_air_wifi_gsm }
        if (hardware == "iPad4,3") { return .ipad_air_wifi_cdma }
        if (hardware == "iPad4,4") { return .ipad_mini_retina_wifi }
        if (hardware == "iPad4,5") { return .ipad_mini_retina_wifi_cdma }
        if (hardware == "iPad4,6") { return .ipad_mini_retina_wifi_cellular_cn }
        if (hardware == "iPad4,7") { return .ipad_mini_3_wifi }
        if (hardware == "iPad4,8") { return .ipad_mini_3_wifi_cellular }
        if (hardware == "iPad4,9") { return .ipad_mini_3_wifi_cellular_cn }
        if (hardware == "iPad5,1") { return .ipad_mini_4_wifi }
        if (hardware == "iPad5,2") { return .ipad_mini_4_wifi_cellular }
        if (hardware == "iPad5,3") { return .ipad_air_2_wifi }
        if (hardware == "iPad5,4") { return .ipad_air_2_wifi_cellular }
        if (hardware == "iPad6,11") { return .ipad_5_wifi }
        if (hardware == "iPad6,12") { return .ipad_5_wifi_cellular }
        if (hardware == "iPad6,3") { return .ipad_pro_97_wifi }
        if (hardware == "iPad6,4") { return .ipad_pro_97_wifi_cellular }
        if (hardware == "iPad6,7") { return .ipad_pro_wifi }
        if (hardware == "iPad6,8") { return .ipad_pro_wifi_cellular }
        if (hardware == "iPad7,1") { return .ipad_pro_2g_wifi }
        if (hardware == "iPad7,11") { return .ipad_7_wifi }
        if (hardware == "iPad7,2") { return .ipad_pro_2g_wifi_cellular }
        if (hardware == "iPad7,3") { return .ipad_pro_105_wifi }
        if (hardware == "iPad7,4") { return .ipad_pro_105_wifi_cellular }
        if (hardware == "iPad7,5") { return .ipad_6_wifi }
        if (hardware == "iPad7,6") { return .ipad_6_wifi_cellular }
        if (hardware == "iPad8,1") { return .ipad_pro_11_wifi }
        if (hardware == "iPad8,2") { return .ipad_pro_11_1tb_wifi }
        if (hardware == "iPad8,3") { return .ipad_pro_11_wifi_cellular }
        if (hardware == "iPad8,4") { return .ipad_pro_11_1tb_wifi_cellular }
        if (hardware == "iPad8,5") { return .ipad_pro_3g_wifi }
        if (hardware == "iPad8,6") { return .ipad_pro_3g_1tb_wifi }
        if (hardware == "iPad8,7") { return .ipad_pro_3g_wifi_cellular }
        if (hardware == "iPad8,8") { return .ipad_pro_3g_1tb_wifi_cellular }
        if (hardware == "iPhone1,1") { return .iphone_2g }
        if (hardware == "iPhone1,2") { return .iphone_3g }
        if (hardware == "iPhone10,1") { return .iphone_8_cn }
        if (hardware == "iPhone10,2") { return .iphone_8_plus_cn }
        if (hardware == "iPhone10,3") { return .iphone_x_cn }
        if (hardware == "iPhone10,4") { return .iphone_8 }
        if (hardware == "iPhone10,5") { return .iphone_8_plus }
        if (hardware == "iPhone10,6") { return .iphone_x }
        if (hardware == "iPhone11,2") { return .iphone_xs }
        if (hardware == "iPhone11,4") { return .iphone_xs_max }
        if (hardware == "iPhone11,6") { return .iphone_xs_max_cn }
        if (hardware == "iPhone11,8") { return .iphone_xr }
        if (hardware == "iPhone12,1") { return .iphone_11 }
        if (hardware == "iPhone12,3") { return .iphone_11_pro }
        if (hardware == "iPhone12,5") { return .iphone_11_pro_max }
        if (hardware == "iPhone2,1") { return .iphone_3gs }
        if (hardware == "iPhone3,1") { return .iphone_4 }
        if (hardware == "iPhone3,2") { return .iphone_4 }
        if (hardware == "iPhone3,3") { return .iphone_4_cdma }
        if (hardware == "iPhone4,1") { return .iphone_4s }
        if (hardware == "iPhone5,1") { return .iphone_5 }
        if (hardware == "iPhone5,2") { return .iphone_5_cdma_gsm }
        if (hardware == "iPhone5,3") { return .iphone_5c }
        if (hardware == "iPhone5,4") { return .iphone_5c_cdma_gsm }
        if (hardware == "iPhone6,1") { return .iphone_5s }
        if (hardware == "iPhone6,2") { return .iphone_5s_cdma_gsm }
        if (hardware == "iPhone7,1") { return .iphone_6_plus }
        if (hardware == "iPhone7,2") { return .iphone_6 }
        if (hardware == "iPhone8,1") { return .iphone_6s }
        if (hardware == "iPhone8,2") { return .iphone_6s_plus }
        if (hardware == "iPhone8,4") { return .iphone_se }
        if (hardware == "iPhone9,1") { return .iphone_7 }
        if (hardware == "iPhone9,2") { return .iphone_7_plus }
        if (hardware == "iPhone9,3") { return .iphone_7_gsm }
        if (hardware == "iPhone9,4") { return .iphone_7_plus_gsm }
        if (hardware == "iPod1,1") { return .ipod_touch_1g }
        if (hardware == "iPod2,1") { return .ipod_touch_2g }
        if (hardware == "iPod3,1") { return .ipod_touch_3g }
        if (hardware == "iPod4,1") { return .ipod_touch_4g }
        if (hardware == "iPod5,1") { return .ipod_touch_5g }
        if (hardware == "iPod7,1") { return .ipod_touch_6g }
        if (hardware == "iPod9,1") { return .ipod_touch_7g }
        if (hardware == "x86_64") { return .simulator }

        //log message that your device is not present in the list
        logMessage(hardware)
        if (hardware.hasPrefix("iPhone")) { return .unknownIphone }
        if (hardware.hasPrefix("iPod")) { return .unknownIpod }
        if (hardware.hasPrefix("iPad")) { return .unknownIpad }
        if (hardware.hasPrefix("Watch")) { return .unknownAppleWatch }
        if (hardware.hasPrefix("AppleTV")) { return .unknownAppleTV }

        return .unknownDevice
    }
}
