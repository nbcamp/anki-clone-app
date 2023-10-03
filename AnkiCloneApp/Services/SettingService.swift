final class SettingService {
    static let shared: SettingService = .init()
    private init() {}

    var storage: Storage = UserDefaultsStorage.shared

    var currentSettings: SettingModel? {
        get {
            return storage.load(forKey: "userSettings")
        }
        set {
            storage.save(newValue, forKey: "userSettings")
        }
    }
}
