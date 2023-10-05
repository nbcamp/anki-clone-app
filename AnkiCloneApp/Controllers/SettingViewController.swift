import UIKit
import EventBus

struct ShowNotificationManagementActionEvent: EventProtocol {
    struct Payload {
        let completionHandler: () -> Void
    }

    let payload: Payload
} 

final class SettingViewController: RootViewController<SettingView> {
    override func viewDidLoad() {
        super.viewDidLoad()
        rootView.setting = SettingService.shared.setting
        title = rootView.setting?.viewControllerTitle
        
        EventBus.shared.on(ShowNotificationManagementActionEvent.self, by: self) { listener, payload in
            listener.showNotificationManagementActionSheet(completionHandler: payload.completionHandler)
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
}
