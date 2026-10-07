#!/usr/bin/env swift

import Foundation

// MARK: - Functions

struct Model: Hashable {

    let version: Version
    let enumCase: String

    func hash(into hasher: inout Hasher) {
        hasher.combine(enumCase)
    }

    static func ==(lhs: Model, rhs: Model) -> Bool {
        return lhs.enumCase == rhs.enumCase
    }
}

struct Version: Comparable {
    let major: Int
    let minor: Int

    static func < (lhs: Version, rhs: Version) -> Bool {
        if lhs.major == rhs.major {
            return lhs.minor < rhs.minor
        } else {
            return lhs.major < rhs.major
        }
    }

    static func == (lhs: Version, rhs: Version) -> Bool {
        lhs.major == rhs.major && lhs.minor == rhs.minor
    }
}

func getUniqueSortedModels(havingPrefix: String, from deviceList: [String: [String: AnyObject]]) -> [Model] {

    let filteredDict = deviceList.filter { $0.key.hasPrefix(havingPrefix) }
    let models: [Model] = filteredDict.compactMap { key, value in

        guard let versionString = findMatch(for: "[\\d]*,[\\d]*", in: key),
              let version =  getVersion(from: versionString),
              let enumCase = value["enum"] as? String else {
            debugPrint("Can't create model from this: \(value)")
            return nil
        }
        return Model(version: version, enumCase: enumCase)
    }

    // Get the unique models i.e. ignore models which has same enum, we don't want same enum twice in case that
    // will cause compiler error
    let sortedModels = models.sorted { $0.version < $1.version }
    var modelSet = Set<Model>()
    sortedModels.forEach { modelSet.insert($0) }
    return modelSet.sorted { $0.version < $1.version }
}

func readPropertyList() -> [String: [String: AnyObject]]? {
    var propertyListFormat =  PropertyListSerialization.PropertyListFormat.xml
    let plistPath: String = "GeneratorDeviceList.plist"
    let plistXML = FileManager.default.contents(atPath: plistPath)!
    do {//convert the data to a dictionary and handle errors.
        let plistData = try PropertyListSerialization.propertyList(from: plistXML,
                                                               options: .mutableContainersAndLeaves,
                                                               format: &propertyListFormat)
        guard let dictionary = plistData as? [String: [String: AnyObject]] else {
            debugPrint("Unable to convert plist into dictionary.")
            return nil
        }
        return dictionary
    } catch {
        debugPrint("Error reading plist: \(error), format: \(propertyListFormat)")
        return nil
    }
}


func normalizedEnum(_ enumCase: String) -> String {
    let lowerCasedEnum = enumCase.lowercased()
    if lowerCasedEnum == "iphone" || lowerCasedEnum == "ipad" || lowerCasedEnum == "ipod" {
        return "iP" + lowerCasedEnum.dropFirst(2)
    } else if lowerCasedEnum == "x86_64" || lowerCasedEnum == "i386" || lowerCasedEnum == "arm64" {
        return lowerCasedEnum + "_simulator"
    } else {
        return lowerCasedEnum
    }
}

func main() {

    guard let generatorDeviceList = readPropertyList() else { return }
    let tabSpacing = "    "
    let unknownCase = "unknownDevice"
    let unknownIphoneCase = "unknownIphone"
    let unknownIpodCase = "unknownIpod"
    let unknownIpadCase = "unknownIpad"
    let unknownAppleWatchCase = "unknownAppleWatch"
    let unknownAppleTVCase = "unknownAppleTV"

    guard let libraryVersion = readPodspecVersion(inDirectory: "..") else {
        debugPrint("Unable to read version from .podspec in the parent directory.")
        return
    }
    debugPrint("Library version: \(libraryVersion)")

    var deviceList: [String: [String: AnyObject]] = [:]

    // DeviceList.plist generation
    generatorDeviceList.keys.sorted().forEach { hardwareKey in
        var valueDict = generatorDeviceList[hardwareKey]
        valueDict?.removeValue(forKey: "enum")
        deviceList[hardwareKey] = valueDict
    }
    let dirPath = "../Sources/"

    debugPrint("Writing plist.")
    guard (deviceList as NSDictionary).write(toFile: "\(dirPath)DeviceList.plist", atomically: true) else {
        debugPrint("Unable to write the plist.")
        return
    }
    debugPrint("Plist created.")

    // Enum file generatoin
    let enumFile = "Hardware.swift"

    var enumString = "// Copyright @DeviceGuru\n"
        + "\npublic enum Hardware {\n"
        + "\n\(tabSpacing)case \(unknownCase)"
        + "\n\(tabSpacing)case \(unknownIphoneCase)"
        + "\n\(tabSpacing)case \(unknownIpodCase)"
        + "\n\(tabSpacing)case \(unknownIpadCase)"
        + "\n\(tabSpacing)case \(unknownAppleWatchCase)"
        + "\n\(tabSpacing)case \(unknownAppleTVCase)\n"

        + "\n\(tabSpacing)case simulator\n"

    // Get devices by device type
    let iPhoneModels = getUniqueSortedModels(havingPrefix: "iPhone", from: generatorDeviceList)
    iPhoneModels.forEach {
        let swiftEnumCase = normalizedEnum($0.enumCase)
        enumString += "\n\(tabSpacing)case \(swiftEnumCase)"
    }
    enumString += "\n"

    let iPodModels = getUniqueSortedModels(havingPrefix: "iPod", from: generatorDeviceList)
    iPodModels.forEach {
        let swiftEnumCase = normalizedEnum($0.enumCase)
        enumString += "\n\(tabSpacing)case \(swiftEnumCase)"
    }
    enumString += "\n"

    let iPadModels = getUniqueSortedModels(havingPrefix: "iPad", from: generatorDeviceList)
    iPadModels.forEach {
        let swiftEnumCase = normalizedEnum($0.enumCase)
        enumString += "\n\(tabSpacing)case \(swiftEnumCase)"
    }
    enumString += "\n"

    let watchModels = getUniqueSortedModels(havingPrefix: "Watch", from: generatorDeviceList)
    watchModels.forEach {
        let swiftEnumCase = normalizedEnum($0.enumCase)
        enumString += "\n\(tabSpacing)case \(swiftEnumCase)"
    }
    enumString += "\n"

    let appleTVModels = getUniqueSortedModels(havingPrefix: "AppleTV", from: generatorDeviceList)
    appleTVModels.forEach {
        let swiftEnumCase = normalizedEnum($0.enumCase)
        enumString += "\n\(tabSpacing)case \(swiftEnumCase)"
    }

    debugPrint("Creating \(enumFile)")
    do {
        let enumFileConent = enumString + "\n}\n"
        try enumFileConent.write(toFile: dirPath + enumFile, atomically: true, encoding: .utf8)
        debugPrint("Created \(enumFile)")
    } catch {
        debugPrint("Unable to create \(enumFile)")
        return
    }

    // Extension file generation
    var hardwareFuncContent = ""
    let extensionFile = "DeviceGuruImplementation+Extension.swift"
    generatorDeviceList.keys.sorted().forEach { hardwareKey in
        let valueDict = generatorDeviceList[hardwareKey]
        guard let enumCase = valueDict?["enum"] as? String else {
            debugPrint("case not present of key \(hardwareKey)")
            return
        }

        let enumCaseString = normalizedEnum(enumCase)
        hardwareFuncContent += "\n\(tabSpacing)\(tabSpacing)if (hardwareString == \"\(hardwareKey)\") { return .\(enumCaseString) }"
    }

    debugPrint("Creating \(extensionFile)")
    do {
        let extensionFileConent = "\npublic extension DeviceGuruImplementation {\n\n"
            + "\(tabSpacing)/// This should be same as cocoa pod version\n"
            + "\(tabSpacing)static var libraryVersion: String { \"\(libraryVersion)\" }\n\n"
            + "\(tabSpacing)var hardware: Hardware {\n"
            + hardwareFuncContent
            + "\n\n"
            + "\(tabSpacing)\(tabSpacing)//log message that your device is not present in the list\n"
            + "\(tabSpacing)\(tabSpacing)logMessage(hardwareString)\n"
            + "\(tabSpacing)\(tabSpacing)if (hardwareString.hasPrefix(\"iPhone\")) { return .\(unknownIphoneCase) }\n"
            + "\(tabSpacing)\(tabSpacing)if (hardwareString.hasPrefix(\"iPod\")) { return .\(unknownIpodCase) }\n"
            + "\(tabSpacing)\(tabSpacing)if (hardwareString.hasPrefix(\"iPad\")) { return .\(unknownIpadCase) }\n"
            + "\(tabSpacing)\(tabSpacing)if (hardwareString.hasPrefix(\"Watch\")) { return .\(unknownAppleWatchCase) }\n"
            + "\(tabSpacing)\(tabSpacing)if (hardwareString.hasPrefix(\"AppleTV\")) { return .\(unknownAppleTVCase) }\n\n"
            + "\(tabSpacing)\(tabSpacing)return .unknownDevice\n"
            + "\(tabSpacing)}\n"
            + "}\n"
        try extensionFileConent.write(toFile: dirPath + extensionFile, atomically: true, encoding: .utf8)
        debugPrint("Created \(extensionFile)")
    } catch {
        debugPrint("Unable to create \(extensionFile)")
        return
    }

}

func findMatch(for regex: String, in text: String) -> String? {
    do {
        let regex = try NSRegularExpression(pattern: regex)
        let results = regex.matches(in: text, range: NSRange(text.startIndex..., in: text))
        return results.compactMap {
            guard let range = Range($0.range, in: text) else {
                debugPrint("Unable to create the range for: \(text)")
                return nil
            }
            return String(text[range])
        }.first
    } catch let error {
        debugPrint("invalid regex: \(error.localizedDescription)")
        return nil
    }
}

func getVersion(from string: String) -> Version? {
    let components = string.components(separatedBy: ",")
    guard components.count == 2 else {
        debugPrint("Can't create components of string: \(string)")
        return nil
    }
    let majorString = components[0].trimmingCharacters(in: .whitespacesAndNewlines)
    let minorString = components[1].trimmingCharacters(in: .whitespacesAndNewlines)

    guard let major = Int(majorString), let minor = Int(minorString) else {
        debugPrint("Can't create major: \(majorString) and  minor: \(minorString)")
        return nil
    }
    return Version(major: major, minor: minor)
}

/// Reads `spec.version = 'X.Y.Z'` from the first .podspec found in the given directory.
func readPodspecVersion(inDirectory directory: String) -> String? {
    guard let files = try? FileManager.default.contentsOfDirectory(atPath: directory),
          let podspec = files.first(where: { $0.hasSuffix(".podspec") }),
          let content = try? String(contentsOfFile: "\(directory)/\(podspec)", encoding: .utf8),
          let line = findMatch(for: "spec\\.version\\s*=\\s*['\"][^'\"]+['\"]", in: content),
          let version = findMatch(for: "[0-9]+(\\.[0-9]+)+", in: line) else {
        return nil
    }
    return version
}

// MARK: - Calling Main

main()
