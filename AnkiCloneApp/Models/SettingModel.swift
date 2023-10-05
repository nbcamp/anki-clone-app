import Foundation

enum NotificationOption: String, Codable {
    case everyday
    case weekdays
    case none
}

struct SettingModel: Codable {
    var notificationOption: NotificationOption
    var reminderTime: Date
    var isShowInAppNotifications: Bool
    
    init(from setting: SettingViewModel) {
        notificationOption = setting.notificationOption
        reminderTime = setting.reminderTime
        isShowInAppNotifications = setting.isShowInAppNotifications
    }
}

extension SettingModel {
    func toViewModel() -> SettingViewModel {
        return .init(
            notificationOption: notificationOption,
            reminderTime: reminderTime,
            isShowInAppNotifications: isShowInAppNotifications
        )
    }
}
