// Copyright @DeviceGuru

import XCTest

@testable import DeviceGuru

// Run Test on iPhone 8

final class HardwareDetailProviderImplementationTests: XCTestCase {

    func testExample() {
        let hardwareProvider = HardwareDetailProviderImplementation()
        XCTAssertEqual(hardwareProvider.hardwareString, "iPhone10,4")
    }
}
