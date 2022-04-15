//  Copyright @DeviceGuru

import XCTest
@testable import DeviceGuru

class DeviceGuruTests: XCTestCase {

    private var sut: DeviceGuruImplementation!
    private var localStorageMock: LocalStorageMock!

    override func setUp() {
        super.setUp()
        localStorageMock = LocalStorageMock()
        let testBundle = Bundle(for: type(of: self))
        let filePath = testBundle.path(forResource: "DeviceList", ofType: "plist")
        sut = DeviceGuruImplementation(localStorage: localStorageMock, plistPath: filePath)
    }

    override func tearDown() {
        sut = nil
        localStorageMock = nil
        super.tearDown()
    }

    func testExample() {
    }
}
