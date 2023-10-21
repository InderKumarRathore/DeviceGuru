// Copyright @DeviceGuru

import XCTest

@testable import DeviceGuru

// Run Test on iPhone 15 pro

final class HardwareDetailProviderImplementationTests: XCTestCase {

    func testExample() {
        let hardwareProvider = HardwareDetailProviderImplementation()
        XCTAssertEqual(hardwareProvider.hardwareString, "iPhone16,1")
    }
}
