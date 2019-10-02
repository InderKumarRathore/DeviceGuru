# DeviceGuru

***DeviceGuru*** is a simple lib (Swift) to know the exact type of the device, e.g. iPhone 6 or iPhone 6s. For Objective-C please visit [DeviceUtil](https://github.com/InderKumarRathore/DeviceUtil)
  - Easy to use
  - Light weight

**From version `5.0.0` it can also identify the simulator type, whether it's iPhone XR or iPhone 6**

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

##### Using Carthage
Specify DeviceGuru into your project's `Cartfile`:

```ogdl
github "InderKumarRathore/DeviceGuru"
```

##### Manually
Drag and drop
``` swift
DeviceGuru.swift
Hardware.swift
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
let deviceGuru = DeviceGuru()
let deviceName = deviceGuru.hardware()
let deviceCode = deviceGuru.hardwareString()
let platform = deviceGuru.platform()
print("\(deviceName) - \(deviceCode) - \(platform.rawValue)") //Ex: iphone_7_PLUS - iPhone9,2 - iphone
```


### Development

Want to contribute? Great!
Just update the `GeneratorDevice.plist`

Then
```sh
cd Generator
./main.swift
```
The above command will auto generate the required code

Send the pull request 🚀


### License
DeviceGuru is available under the MIT license. See the LICENSE file for more info.
