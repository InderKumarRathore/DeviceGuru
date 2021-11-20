
public extension DeviceGuruImplementation {

    /// This should be same as cocoa pod version
    static var libraryVersion: String { "9.0.0" }

    var hardware: Hardware {

        if (hardwareString == "AppleTV1,1") { return .apple_tv_1g }
        if (hardwareString == "AppleTV2,1") { return .apple_tv_2g }
        if (hardwareString == "AppleTV3,1") { return .apple_tv_3g }
        if (hardwareString == "AppleTV3,2") { return .apple_tv_3_2g }
        if (hardwareString == "AppleTV5,3") { return .apple_tv_4g }
        if (hardwareString == "AppleTV6,2") { return .apple_tv_4k }
        if (hardwareString == "Watch1,1") { return .apple_watch_38 }
        if (hardwareString == "Watch1,2") { return .apple_watch_42 }
        if (hardwareString == "Watch2,3") { return .apple_watch_series_2_38 }
        if (hardwareString == "Watch2,4") { return .apple_watch_series_2_42 }
        if (hardwareString == "Watch2,6") { return .apple_watch_series_1_38 }
        if (hardwareString == "Watch2,7") { return .apple_watch_series_1_42 }
        if (hardwareString == "Watch3,1") { return .apple_watch_series_3_38_cellular }
        if (hardwareString == "Watch3,2") { return .apple_watch_series_3_42_cellular }
        if (hardwareString == "Watch3,3") { return .apple_watch_series_3_38 }
        if (hardwareString == "Watch3,4") { return .apple_watch_series_3_42 }
        if (hardwareString == "Watch4,1") { return .apple_watch_series_4_40 }
        if (hardwareString == "Watch4,2") { return .apple_watch_series_4_44 }
        if (hardwareString == "Watch4,3") { return .apple_watch_series_4_40_cellular }
        if (hardwareString == "Watch4,4") { return .apple_watch_series_4_44_cellular }
        if (hardwareString == "Watch5,1") { return .apple_watch_series_5_40 }
        if (hardwareString == "Watch5,2") { return .apple_watch_series_5_44 }
        if (hardwareString == "Watch5,3") { return .apple_watch_series_5_40_cellular }
        if (hardwareString == "Watch5,4") { return .apple_watch_series_5_44_cellular }
        if (hardwareString == "arm64") { return .simulator }
        if (hardwareString == "i386") { return .simulator }
        if (hardwareString == "iPad1,1") { return .iPad }
        if (hardwareString == "iPad1,2") { return .ipad_3g }
        if (hardwareString == "iPad11,1") { return .ipad_mini_5_wifi }
        if (hardwareString == "iPad11,2") { return .ipad_mini_5_wifi_cellular }
        if (hardwareString == "iPad11,3") { return .ipad_air_3_wifi }
        if (hardwareString == "iPad11,4") { return .ipad_air_3_wifi_cellular }
        if (hardwareString == "iPad11,6") { return .ipad_8g_wifi }
        if (hardwareString == "iPad11,7") { return .ipad_8g_wifi_cellular }
        if (hardwareString == "iPad13,1") { return .ipad_air_4_wifi }
        if (hardwareString == "iPad13,2") { return .ipad_air_4_wifi_cellular }
        if (hardwareString == "iPad2,1") { return .ipad_2_wifi }
        if (hardwareString == "iPad2,2") { return .ipad_2 }
        if (hardwareString == "iPad2,3") { return .ipad_2_cdma }
        if (hardwareString == "iPad2,4") { return .ipad_2 }
        if (hardwareString == "iPad2,5") { return .ipad_mini_wifi }
        if (hardwareString == "iPad2,6") { return .ipad_mini }
        if (hardwareString == "iPad2,7") { return .ipad_mini_wifi_cdma }
        if (hardwareString == "iPad3,1") { return .ipad_3_wifi }
        if (hardwareString == "iPad3,2") { return .ipad_3_wifi_cdma }
        if (hardwareString == "iPad3,3") { return .ipad_3 }
        if (hardwareString == "iPad3,4") { return .ipad_4_wifi }
        if (hardwareString == "iPad3,5") { return .ipad_4 }
        if (hardwareString == "iPad3,6") { return .ipad_4_gsm_cdma }
        if (hardwareString == "iPad4,1") { return .ipad_air_wifi }
        if (hardwareString == "iPad4,2") { return .ipad_air_wifi_gsm }
        if (hardwareString == "iPad4,3") { return .ipad_air_wifi_cdma }
        if (hardwareString == "iPad4,4") { return .ipad_mini_retina_wifi }
        if (hardwareString == "iPad4,5") { return .ipad_mini_retina_wifi_cdma }
        if (hardwareString == "iPad4,6") { return .ipad_mini_retina_wifi_cellular_cn }
        if (hardwareString == "iPad4,7") { return .ipad_mini_3_wifi }
        if (hardwareString == "iPad4,8") { return .ipad_mini_3_wifi_cellular }
        if (hardwareString == "iPad4,9") { return .ipad_mini_3_wifi_cellular_cn }
        if (hardwareString == "iPad5,1") { return .ipad_mini_4_wifi }
        if (hardwareString == "iPad5,2") { return .ipad_mini_4_wifi_cellular }
        if (hardwareString == "iPad5,3") { return .ipad_air_2_wifi }
        if (hardwareString == "iPad5,4") { return .ipad_air_2_wifi_cellular }
        if (hardwareString == "iPad6,11") { return .ipad_5_wifi }
        if (hardwareString == "iPad6,12") { return .ipad_5_wifi_cellular }
        if (hardwareString == "iPad6,3") { return .ipad_pro_97_wifi }
        if (hardwareString == "iPad6,4") { return .ipad_pro_97_wifi_cellular }
        if (hardwareString == "iPad6,7") { return .ipad_pro_wifi }
        if (hardwareString == "iPad6,8") { return .ipad_pro_wifi_cellular }
        if (hardwareString == "iPad7,1") { return .ipad_pro_2g_wifi }
        if (hardwareString == "iPad7,11") { return .ipad_7_wifi }
        if (hardwareString == "iPad7,12") { return .ipad_7_wifi_cellular }
        if (hardwareString == "iPad7,2") { return .ipad_pro_2g_wifi_cellular }
        if (hardwareString == "iPad7,3") { return .ipad_pro_105_wifi }
        if (hardwareString == "iPad7,4") { return .ipad_pro_105_wifi_cellular }
        if (hardwareString == "iPad7,5") { return .ipad_6_wifi }
        if (hardwareString == "iPad7,6") { return .ipad_6_wifi_cellular }
        if (hardwareString == "iPad8,1") { return .ipad_pro_11_wifi }
        if (hardwareString == "iPad8,10") { return .ipad_pro_11_2g_wifi_cellular }
        if (hardwareString == "iPad8,11") { return .ipad_pro_4g_wifi }
        if (hardwareString == "iPad8,12") { return .ipad_pro_4g_wifi_cellular }
        if (hardwareString == "iPad8,2") { return .ipad_pro_11_1tb_wifi }
        if (hardwareString == "iPad8,3") { return .ipad_pro_11_wifi_cellular }
        if (hardwareString == "iPad8,4") { return .ipad_pro_11_1tb_wifi_cellular }
        if (hardwareString == "iPad8,5") { return .ipad_pro_3g_wifi }
        if (hardwareString == "iPad8,6") { return .ipad_pro_3g_1tb_wifi }
        if (hardwareString == "iPad8,7") { return .ipad_pro_3g_wifi_cellular }
        if (hardwareString == "iPad8,8") { return .ipad_pro_3g_1tb_wifi_cellular }
        if (hardwareString == "iPad8,9") { return .ipad_pro_11_2g_wifi }
        if (hardwareString == "iPhone1,1") { return .iphone_2g }
        if (hardwareString == "iPhone1,2") { return .iphone_3g }
        if (hardwareString == "iPhone10,1") { return .iphone_8_cn }
        if (hardwareString == "iPhone10,2") { return .iphone_8_plus_cn }
        if (hardwareString == "iPhone10,3") { return .iphone_x_cn }
        if (hardwareString == "iPhone10,4") { return .iphone_8 }
        if (hardwareString == "iPhone10,5") { return .iphone_8_plus }
        if (hardwareString == "iPhone10,6") { return .iphone_x }
        if (hardwareString == "iPhone11,2") { return .iphone_xs }
        if (hardwareString == "iPhone11,4") { return .iphone_xs_max }
        if (hardwareString == "iPhone11,6") { return .iphone_xs_max_cn }
        if (hardwareString == "iPhone11,8") { return .iphone_xr }
        if (hardwareString == "iPhone12,1") { return .iphone_11 }
        if (hardwareString == "iPhone12,3") { return .iphone_11_pro }
        if (hardwareString == "iPhone12,5") { return .iphone_11_pro_max }
        if (hardwareString == "iPhone12,8") { return .iphone_se_2g }
        if (hardwareString == "iPhone13,1") { return .iphone_12_mini }
        if (hardwareString == "iPhone13,2") { return .iphone_12 }
        if (hardwareString == "iPhone13,3") { return .iphone_12_pro }
        if (hardwareString == "iPhone13,4") { return .iphone_12_pro_max }
        if (hardwareString == "iPhone14,2") { return .iphone_13_pro }
        if (hardwareString == "iPhone14,3") { return .iphone_13_pro_max }
        if (hardwareString == "iPhone14,4") { return .iphone_13_mini }
        if (hardwareString == "iPhone14,5") { return .iphone_13 }
        if (hardwareString == "iPhone2,1") { return .iphone_3gs }
        if (hardwareString == "iPhone3,1") { return .iphone_4 }
        if (hardwareString == "iPhone3,2") { return .iphone_4 }
        if (hardwareString == "iPhone3,3") { return .iphone_4_cdma }
        if (hardwareString == "iPhone4,1") { return .iphone_4s }
        if (hardwareString == "iPhone5,1") { return .iphone_5 }
        if (hardwareString == "iPhone5,2") { return .iphone_5_cdma_gsm }
        if (hardwareString == "iPhone5,3") { return .iphone_5c }
        if (hardwareString == "iPhone5,4") { return .iphone_5c_cdma_gsm }
        if (hardwareString == "iPhone6,1") { return .iphone_5s }
        if (hardwareString == "iPhone6,2") { return .iphone_5s_cdma_gsm }
        if (hardwareString == "iPhone7,1") { return .iphone_6_plus }
        if (hardwareString == "iPhone7,2") { return .iphone_6 }
        if (hardwareString == "iPhone8,1") { return .iphone_6s }
        if (hardwareString == "iPhone8,2") { return .iphone_6s_plus }
        if (hardwareString == "iPhone8,4") { return .iphone_se }
        if (hardwareString == "iPhone9,1") { return .iphone_7 }
        if (hardwareString == "iPhone9,2") { return .iphone_7_plus }
        if (hardwareString == "iPhone9,3") { return .iphone_7_gsm }
        if (hardwareString == "iPhone9,4") { return .iphone_7_plus_gsm }
        if (hardwareString == "iPod1,1") { return .ipod_touch_1g }
        if (hardwareString == "iPod2,1") { return .ipod_touch_2g }
        if (hardwareString == "iPod3,1") { return .ipod_touch_3g }
        if (hardwareString == "iPod4,1") { return .ipod_touch_4g }
        if (hardwareString == "iPod5,1") { return .ipod_touch_5g }
        if (hardwareString == "iPod7,1") { return .ipod_touch_6g }
        if (hardwareString == "iPod9,1") { return .ipod_touch_7g }
        if (hardwareString == "x86_64") { return .simulator }

        //log message that your device is not present in the list
        Self.logMessage(hardwareString)
        if (hardwareString.hasPrefix("iPhone")) { return .unknownIphone }
        if (hardwareString.hasPrefix("iPod")) { return .unknownIpod }
        if (hardwareString.hasPrefix("iPad")) { return .unknownIpad }
        if (hardwareString.hasPrefix("Watch")) { return .unknownAppleWatch }
        if (hardwareString.hasPrefix("AppleTV")) { return .unknownAppleTV }

        return .unknownDevice
    }
}
