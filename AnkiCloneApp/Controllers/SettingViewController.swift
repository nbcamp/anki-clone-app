import UIKit
import EventBus

struct ShowNotificationManagementActionEvent: EventProtocol {
    let payload: Void = ()
}

final class SettingViewController: RootViewController<SettingView> {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        EventBus.shared.on(ShowNotificationManagementActionEvent.self) { _ in
            self.showNotificationManagementActionSheet()
        }
    }
    
    func showNotificationManagementActionSheet() {
        let actionSheet = UIAlertController(
            title: "알림 관리",
            message: "리마인더 알림은 하루에 한 번 전송됩니다.",
            preferredStyle: .actionSheet
        )
        
        let dailyAction = UIAlertAction(title: "매일", style: .default) { (_) in
             //self.saveNotificationOption(.everyday)
         }
         
         let weekdaysAction = UIAlertAction(title: "평일", style: .default) { (_) in
             //self.saveNotificationOption(.weekdays)
         }
         
         let noneAction = UIAlertAction(title: "안 함", style: .default) { (_) in
             //self.saveNotificationOption(.none)
         }
         
         let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
         
         actionSheet.addAction(dailyAction)
         actionSheet.addAction(weekdaysAction)
         actionSheet.addAction(noneAction)
         actionSheet.addAction(cancelAction)
        
        present(actionSheet, animated: true, completion: nil)
    }
}
