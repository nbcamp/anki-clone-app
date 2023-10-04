//
//  SettingViewModel.swift
//  AnkiCloneApp
//
//  Created by daelee on 2023/10/04.
//
import Publishable
import Foundation

class SettingViewModel {
    @Publishable var notificationOption: NotificationOption
    @Publishable var reminderTime: Date
    @Publishable var isShowInAppNotifications: Bool
    
    init(notificationOption: NotificationOption, reminderTime: Date, isShowInAppNotifications: Bool) {
        self.notificationOption = notificationOption
        self.reminderTime = reminderTime
        self.isShowInAppNotifications = isShowInAppNotifications
    }
}

extension SettingViewModel {
    func toModel() -> SettingModel { .init(from: self) }
}
