import Foundation

final class SettingService {
    static let shared: SettingService = .init()
    private init() {}
    
    private lazy var key: String = .init(describing: self)
    var storage: Storage? { didSet { setting = load() ?? setting }}
    private(set) var setting: SettingViewModel = .init(notificationOption: .none, reminderTime: Date(), isShowInAppNotifications: true)
    
    func updateNotificationOption(_ newOption: NotificationOption) {
        var newSetting = setting
        
        newSetting.notificationOption = newOption
        setting = newSetting
        save(setting: newSetting)
    }
    
    func updateReminderTime(_ newOption: Date) {
        var newSetting = setting
        
        newSetting.reminderTime = newOption
        setting = newSetting
        save(setting: newSetting)
    }
    
    func updateIsShowInAppNotifications(_ newOption: Bool) {
        var newSetting = setting
        
        newSetting.isShowInAppNotifications = newOption
        setting = newSetting
        save(setting: newSetting)
    }
}

extension SettingService {
    private func save(setting: SettingViewModel) {
        storage?.save(setting.toModel(), forKey: key)
    }

    private func load() -> SettingViewModel? {
        guard let model: SettingModel = storage?.load(forKey: key) else { return nil }
        return model.toViewModel()
    }
}
