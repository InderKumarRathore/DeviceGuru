//
//  DeviceVersion.swift
//
//  Created by Inder Kumar Rathore on 01/11/20.
//  Copyright (c) 2020. All rights reserved.
//

import Foundation

public struct DeviceVersion: Comparable {
    public let major: Int
    public let minor: Int

    public init(major: Int, minor: Int) {
        self.major = major
        self.minor = minor
    }

    public static func < (lhs: DeviceVersion, rhs: DeviceVersion) -> Bool {
        if lhs.major == rhs.major {
            return lhs.minor < rhs.minor
        } else {
            return lhs.major < rhs.major
        }
    }

    public static func == (lhs: DeviceVersion, rhs: DeviceVersion) -> Bool {
        lhs.major == rhs.major && lhs.minor == rhs.minor
    }
}
