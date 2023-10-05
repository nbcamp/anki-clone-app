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
    
    let viewControllerTitle: String = "설정"
    let notificationOptionTitle: String = "알림 관리"
    var notificationOptionSecondaryText: String {
        switch notificationOption {
        case .everyday:
            return "매일"
        case .weekdays:
            return "평일"
        case .none:
            return "안 함"
        }
    }
    let showInAppNotificationsTitle: String = "앱 내 알림 표시"
    let reminderTimeTitle: String = "기본 리마인더 시간"
    var reminderTimeSecondaryText: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm a"
        
        return dateFormatter.string(from: reminderTime)
    }
    
    init(notificationOption: NotificationOption, reminderTime: Date, isShowInAppNotifications: Bool) {
        self.notificationOption = notificationOption
        self.reminderTime = reminderTime
        self.isShowInAppNotifications = isShowInAppNotifications
    }
}

extension SettingViewModel {
    func toModel() -> SettingModel { .init(from: self) }
}
