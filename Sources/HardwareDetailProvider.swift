// Copyright @DeviceGuru

import Foundation

public protocol HardwareDetailProvider {
    var hardwareString: String { get }
}

public struct HardwareDetailProviderImplementation: HardwareDetailProvider {

    public init() {}

    public var hardwareString: String {
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
}
