import UIKit
import EventBus

struct ShowNotificationManagementActionEvent: EventProtocol {
    struct Payload {
        let completionHandler: () -> Void
    }
    
    let payload: Payload
}

struct DatePickerValueChangedEvent: EventProtocol {
    let payload: Date
}

struct SwitchValueChangedEvent: EventProtocol {
    let payload: Bool
}

final class SettingViewController: RootViewController<SettingView> {
    override func viewDidLoad() {
        super.viewDidLoad()
        rootView.setting = SettingService.shared.setting
        title = rootView.setting?.viewControllerTitle
        
        EventBus.shared.on(ShowNotificationManagementActionEvent.self, by: self) { listener, payload in
            listener.showNotificationManagementActionSheet(completionHandler: payload.completionHandler)
        }
        
        EventBus.shared.on(DatePickerValueChangedEvent.self, by: self) { listener, payload in
            listener.handleDatePickerValueChanged(payload)
        }
        
        EventBus.shared.on(SwitchValueChangedEvent.self, by: self) { listener, payload in
            listener.handleSwitchValueChanged(payload)
        }
    }
    
    private func showNotificationManagementActionSheet(completionHandler: @escaping () -> Void) {
        let actionSheet = UIAlertController(
            title: "알림 관리",
            message: "리마인더 알림은 하루에 한 번 전송됩니다.",
            preferredStyle: .actionSheet
        )
        
        let dailyAction = UIAlertAction(title: "매일", style: .default) { (_) in
            SettingService.shared.updateNotificationOption(.everyday)
            completionHandler()
        }
        
        let weekdaysAction = UIAlertAction(title: "평일", style: .default) { (_) in
            SettingService.shared.updateNotificationOption(.weekdays)
            completionHandler()
        }
        
        let noneAction = UIAlertAction(title: "안 함", style: .default) { (_) in
            SettingService.shared.updateNotificationOption(.none)
            completionHandler()
        }
        
        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        actionSheet.addAction(dailyAction)
        actionSheet.addAction(weekdaysAction)
        actionSheet.addAction(noneAction)
        actionSheet.addAction(cancelAction)
        
        present(actionSheet, animated: true, completion: nil)
    }
    
    private func handleDatePickerValueChanged(_ date: Date) {
        SettingService.shared.updateReminderTime(date)
        print(SettingService.shared.setting.reminderTime) // 타임존 변경하기
    }
    
    private func handleSwitchValueChanged(_ isOn: Bool) {
        SettingService.shared.updateIsShowInAppNotifications(isOn)
        SettingService.shared.sendTestNoti() // true로 변경했을 때 앱 내 알림 보이는것 테스트
    }
}
