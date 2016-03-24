# DeviceGuru

***DeviceGuru*** is a simple lib (Swift) to know the exact type of the device, e.g. iPhone 6 or iPhone 6s. For Objective-C please visit [DeviceUtil](https://github.com/InderKumarRathore/DeviceUtil)
  - Easy to use
  - Light weight


### Installation

##### Using pods
Copy the pod dependency and add that to your pod file. e.g.

```sh
pod 'DeviceGuru'
```
then run the below command in terminal
```sh
pod install
```

##### Using without pods
Drag and drop
``` swift
DeviceGuru.swift
DeviceList.plist
```

files in your project

### Usage
If you install from *CocoaPods*, you have to import the module. If you used drag and drop then there is no need of import
``` swift
import DeviceGuru 
```
In your code:
``` swift
let deviceCode = DeviceGuru.hardwareString()
let deviceName = DeviceGuru.hardware()
print("\(deviceName) - \(deviceCode)") //Ex: IPHONE_6S_PLUS - iPhone8,2
```

### Device codes
##### iPhone
Device | hardware() | hardwareString()
--- | --- | ---
iPhone 2G | ```IPHONE_2G``` | ```iPhone1,1```
iPhone 3G | ```IPHONE_3G``` | ```iPhone1,2```
iPhone 3GS| ```IPHONE_3GS``` | ```iPhone2,1```
iPhone 4| ```IPHONE_4``` | ```iPhone3,1```
iPhone 4| ```IPHONE_4``` | ```iPhone3,2```
iPhone 4 CDMA| ```IPHONE_4_CDMA``` | ```iPhone3,3```
iPhone 4S| ```IPHONE_4S``` | ```iPhone4,1```
iPhone 5| ```IPHONE_5``` | ```iPhone5,1```
iPhone 5 CDMA GSM | ```IPHONE_5_CDMA_GSM``` | ```iPhone5,2```
iPhone 5C | ```IPHONE_5C``` | ```iPhone5,3```
iPhone 5C CDMA GSM | ```IPHONE_5C_CDMA_GSM``` | ```iPhone5,4```
iPhone 5S | ```IPHONE_5S``` | ```iPhone6,1```
iPhone 5S CDMA GSM | ```IPHONE_5S_CDMA_GSM``` | ```iPhone6,2```
iPhone 6 Plus | ```IPHONE_6_PLUS``` | ```iPhone7,1```
iPhone 6 | ```IPHONE_6``` | ```iPhone7,2```
iPhone 6s Plus | ```IPHONE_6S_PLUS``` | ```iPhone8,2```
iPhone 6s | ```IPHONE_6S``` | ```iPhone8,2```
iPhone SE | ```IPHONE_SE``` | ```iPhone8,4```

##### iPod
Device | hardware() | hardwareString()
--- | ---- | ---
iPod Touch 1G| ```IPOD_TOUCH_1G``` | ```iPod1,1```
iPod Touch 2G| ```IPOD_TOUCH_2G``` | ```iPod2,1```
iPod Touch 3G| ```IPOD_TOUCH_3G``` | ```iPod3,1```
iPod Touch 4G| ```IPOD_TOUCH_4G``` | ```iPod4,1```
iPod Touch 5G| ```IPOD_TOUCH_5G``` | ```iPod5,1```

##### iPad
Device | hardware() | hardwareString()
--- | --- | ---
iPad | ```IPAD``` | ```iPad1,1```
iPad 3G | ```IPAD_3G``` | ```iPad1,2```
iPad 2 Wifi | ```IPAD_2_WIFI``` | ```iPad2,1```
iPad 2 | ```IPAD_2 ``` | ```iPad2,2```
iPad 2 CDMA | ```IPAD_2_CDMA``` | ```iPad2,3```
iPad 2 | ```IPAD_2``` | ```iPad2,4```
iPad Mini WIFI | ```IPAD_MINI_WIFI``` | ```iPad2,5```
iPad 3 WIFI | ```IPAD_3_WIFI``` | ```iPad3,1```
iPad 3 CDMA | ```IPAD_3_WIFI_CDMA``` | ```iPad3,2```
iPad 3 | ```IPAD_3``` | ```iPad3,3```
iPad 4 WIFI | ```IPAD_4_WIFI``` | ```iPad3,4```
iPad 4 | ```IPAD_4``` | ```iPad3,5```
iPad 4 GSM CDMA | ```IPAD_4_GSM_CDMA``` | ```iPad3,6```
iPad Air | ```IPAD_AIR_WIFI``` | ```iPad4,1```
iPad Air GSM  | ```IPAD_AIR_WIFI_GSM``` | ```iPad4,2```
iPad Air CDMA  | ```IPAD_AIR_WIFI_CDMA``` | ```iPad4,3```
iPad Mini Retina  | ```IPAD_MINI_RETINA_WIFI``` | ```iPad4,4```
iPad Mini Retina CDMA  | ```IPAD_MINI_RETINA_WIFI_CDMA``` | ```iPad4,5```
iPad Mini Retina Cellular CN  | ```IPAD_MINI_RETINA_WIFI_CELLULAR_CN``` | ```iPad4,6```
iPad Mini 3  | ```IPAD_MINI_3_WIFI``` | ```iPad4,7```
iPad Mini 3 Cellular  | ```IPAD_MINI_3_WIFI_CELLULAR``` | ```iPad4,8```
iPad Mini 4  | ```IPAD_MINI_4_WIFI``` | ```iPad5.1```
iPad Mini 4 Cellular  | ```IPAD_MINI_4_WIFI_CELLULAR``` | ```iPad5.2```
iPad Air 2  | ```IPAD_AIR_2_WIFI``` | ```iPad5.3```
iPad Pro  | ```IPAD_PRO_WIFI``` | ```iPad6,7```
iPad Pro Cellular  | ```IPAD_PRO_WIFI_CELLULAR``` | ```iPad6,8```

##### Simulator
Device | hardware() | hardwareString()
--- | --- | ---
Simulator  | ```SIMULATOR``` | ```i386```
Simulator  | ```SIMULATOR``` | ```x86_64```
Simulator  | ```SIMULATOR``` | ```hasPrefix("iPhone")```
Simulator  | ```SIMULATOR``` | ```hasPrefix("iPod")```
Simulator  | ```SIMULATOR``` | ```hasPrefix("iPad)```



### Development

Want to contribute? Great!

Send the pull request :)


### License
DeviceGuru is available under the MIT license. See the LICENSE file for more info.


