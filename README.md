# DeviceGuru

***DeviceGuru*** is a simple lib (Swift) to know the exact type of the device, e.g. iPhone 6 or iPhone 6s. For Objective-C please visit [UIDeviceUtil](https://github.com/InderKumarRathore/UIDeviceUtil)
  - Easy to use
  - Light weight


### Installation

Go to [http://cocoapods.org](http://cocoapods.org) <br>
Search for `DeviceGuru` lib <br>
Copy the pod dependency and add that to your pod file. e.g.

```sh
pod 'DeviceGuru', '~> x.y'
```

### Usage
If you install from *CocoaPods*, you have to write 
``` swift
import DeviceGuru 
```
In your code:
``` swift
let deviceCode = DeviceGuru.hardwareString()
let deviceName = DeviceGuru.hardware()
print("\(deviceName) - \(deviceCode)") //Ex: IPHONE_6S_PLUS - iPhone8,2
```

### Development

Want to contribute? Great!

Send the pull request :)


### License
MIT

