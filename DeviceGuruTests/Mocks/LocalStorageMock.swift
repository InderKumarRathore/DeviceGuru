//  Copyright @DeviceGuru

@testable import DeviceGuru

final class LocalStorageMock: LocalStorage {

    var dictionary: [String: Any?] = [:]

    func setValue(_ value: Any?, forKey key: String) {
        dictionary[key] = value
    }

    func object(forKey defaultName: String) -> Any? {
        dictionary[defaultName]
    }
}
