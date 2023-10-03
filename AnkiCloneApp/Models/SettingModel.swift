struct SettingModel: Codable {
    var notificationOption: NotificationOption
    var reminderTime: String
    var showInAppNotifications: Bool

    enum NotificationOption: String, Codable {
        case everyday
        case weekdays
        case none
    }
}
