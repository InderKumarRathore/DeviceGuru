// Copyright @DeviceGuru

import XCTest

@testable import DeviceGuru

final class HardwareDetailProviderImplementationTests: XCTestCase {

    func testExample() {
        let hardwareProvider = HardwareDetailProviderImplementation()
        XCTAssertTrue(hardwareProvider.hardwareString.contains("iPhone"))
    }
}
