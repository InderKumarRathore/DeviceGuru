// Copyright @DeviceGuru

import XCTest
@testable import DeviceGuru

final class DeviceGuruTests: XCTestCase {

    private var sut: DeviceGuruImplementation!
    private var localStorageMock: LocalStorageMock!
    private var hardwareDetailProviderMock: HardwareDetailProviderMock!
    private let currentLibraryVersion = "10.0.10"

    override func setUp() {
        super.setUp()
        localStorageMock = LocalStorageMock()
        hardwareDetailProviderMock = HardwareDetailProviderMock()
        let testBundle = Bundle(for: type(of: self))
        let filePath = testBundle.path(forResource: "DeviceList", ofType: "plist")
        sut = DeviceGuruImplementation(localStorage: localStorageMock,
                                       hardwareDetailProvider: hardwareDetailProviderMock,
                                       plistPath: filePath)
    }

    override func tearDown() {
        sut = nil
        localStorageMock = nil
        hardwareDetailProviderMock = nil
        super.tearDown()
    }

    func testThatDeviceInfoIsSavedIntoLocalStorageOnFirstRun() throws {
        // when
        let result = try sut.hardwareDescription()

        // then
        XCTAssertEqual(result, "iPhone SE (2nd generation)")
        XCTAssertEqual(localStorageMock.dictionary.keys.count, 2)

        let hardwareDetail = localStorageMock.dictionary[Constants.hardwareDetailKey] as? [String: String]
        XCTAssertEqual(hardwareDetail, ["name": "iPhone SE (2nd generation)"])

        let deviceGuruVersion = localStorageMock.dictionary[Constants.deviceGuruVersionKey] as? String
        XCTAssertEqual(deviceGuruVersion, currentLibraryVersion)
    }

    func testThatDeviceInfoIsFetchedForLocalStorageForSubsequentRequests() throws {
        // given
        localStorageMock.dictionary[Constants.deviceGuruVersionKey] = currentLibraryVersion
        localStorageMock.dictionary[Constants.hardwareDetailKey] = ["name": "Test_Device"]

        // when
        let result = try sut.hardwareDescription()

        // then
        XCTAssertEqual(result, "Test_Device")
        XCTAssertTrue(localStorageMock.getObjectCalled > 0)
        XCTAssertEqual(localStorageMock.setValueCalled, 0)
    }

    func testThatDeviceInfoIsLatestForLocalStorageForNewLibrary() throws {
        // given
        localStorageMock.dictionary[Constants.deviceGuruVersionKey] = "9.9.9"
        localStorageMock.dictionary[Constants.hardwareDetailKey] = ["name": "Test_Device"]

        // when
        let result = try sut.hardwareDescription()

        // then
        XCTAssertEqual(result, "iPhone SE (2nd generation)")
        XCTAssertTrue(localStorageMock.getObjectCalled > 0)
        XCTAssertTrue(localStorageMock.setValueCalled > 0)
    }

    func testHardwareString() {
        hardwareDetailProviderMock.hardwareString = "iPhone12,8"
        XCTAssertEqual(sut.hardwareString, hardwareDetailProviderMock.hardwareString )
    }

    func testHardwareSimpleDescription() throws {
        hardwareDetailProviderMock.hardwareString = "iPad8,8"

        let simpleName = try sut.hardwareSimpleDescription()
        XCTAssertEqual(simpleName, "iPad Pro 12.9-inch")

        let name = try sut.hardwareDescription()
        XCTAssertEqual(name, "iPad Pro 12.9-inch (1TB, Wi-Fi + Cellular, 3rd generation)")
    }

    func testHardwareVersion() throws {
        hardwareDetailProviderMock.hardwareString = "iPad8,10"
        let version = try sut.deviceVersion()
        XCTAssertEqual(version, DeviceVersion(major: 8, minor: 10))
    }

}

// MARK: - Platform

extension DeviceGuruTests {

    func testPlatformForIPhone() {
        hardwareDetailProviderMock.hardwareString = "iPhone12,8"
        XCTAssertEqual(sut.platform, .iPhone)
    }

    func testPlatformForIPad() {
        hardwareDetailProviderMock.hardwareString = "iPad8,12"
        XCTAssertEqual(sut.platform, .iPad)
    }

    func testPlatformForIPod() {
        hardwareDetailProviderMock.hardwareString = "iPod2,1"
        XCTAssertEqual(sut.platform, .iPodTouch)
    }

    func testPlatformForWatch() {
        hardwareDetailProviderMock.hardwareString = "Watch3,2"
        XCTAssertEqual(sut.platform, .appleWatch)
    }

    func testPlatformForTV() {
        hardwareDetailProviderMock.hardwareString = "AppleTV5,3"
        XCTAssertEqual(sut.platform, .appleTV)
    }
}

private enum Constants {
    static let hardwareDetailKey = "github.com/InderKumarRathore/DeviceGuru.HardwareDetail.Key"
    static let deviceGuruVersionKey = "github.com/InderKumarRathore/DeviceGuru.Version.Key"
}
