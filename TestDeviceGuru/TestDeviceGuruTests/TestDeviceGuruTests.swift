//
//  TestDeviceGuruTests.swift
//  TestDeviceGuruTests
//
//  Created by Inder Kumar Rathore on 19/09/17.
//  Copyright © 2017 Inder Kumar Rathore. All rights reserved.
//

import XCTest
import DeviceGuru

class TestDeviceGuruTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
      measure {
        let dG = DeviceGuru()
        let _ = dG.hardwareDescription()
        let _ = dG.hardware()
        let _ = dG.hardwareNumber()
      }
    }
}
