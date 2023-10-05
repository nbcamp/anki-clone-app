import Foundation
import UserNotifications

final class SettingService {
    static let shared: SettingService = .init()
    private init() {}
    
    private lazy var key: String = .init(describing: self)
    var storage: Storage? { didSet { setting = load() ?? setting }}
    private(set) var setting: SettingViewModel = .init(notificationOption: .everyday, reminderTime: Date(), isShowInAppNotifications: false)
    
    func updateNotificationOption(_ newOption: NotificationOption) {
        let newSetting = setting
        
        newSetting.notificationOption = newOption
        setting = newSetting
        save(setting: newSetting)
    }
    
    func updateReminderTime(_ newOption: Date) {
        let newSetting = setting
        
        newSetting.reminderTime = newOption
        setting = newSetting
        save(setting: newSetting)
    }
    
    func updateIsShowInAppNotifications(_ newOption: Bool) {
        let newSetting = setting
        
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

// UserNotifications 관련
extension SettingService {
    func requestNotificationAuthorization() {
        let authOptions: UNAuthorizationOptions = [.alert, .sound, .badge]
        
        UNUserNotificationCenter.current().requestAuthorization(options: authOptions) { (granted, error) in
            if granted {
                print("알림 권한이 허용됨")
            } else {
                print("알림 권한이 거부됨")
            }
        }
    }
    
    func setUserNotificationSettings() {
            switch setting.notificationOption {
            case .everyday:
                sendEverydayNoti()
            case .weekdays:
                setWeekdaysNoti()
            case .none:
                cancelNoti()
            }
        }
    
    private func cancelNoti() {
        let notificationCenter = UNUserNotificationCenter.current()
        
        notificationCenter.removeAllPendingNotificationRequests()
    }
    
    func sendEverydayNoti() {
        let notificationCenter = UNUserNotificationCenter.current()
        
        notificationCenter.removeAllPendingNotificationRequests()
        
        let content = UNMutableNotificationContent()
        content.title = "오늘도 Anki와 함께 공부해봐요!"
        content.body = "터치하면 앱의 메인 화면으로 이동합니다."
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: Calendar.current.dateComponents([.hour, .minute], from: setting.reminderTime), repeats: true)
        
        let request = UNNotificationRequest(
            identifier: "sendEverydayNoti",
            content: content,
            trigger: trigger
        )
        
        if setting.notificationOption != .none {
            notificationCenter.add(request) { (error) in
                if error != nil {}
            }
        }
    }
    
    func setWeekdaysNoti() {
        let notificationCenter = UNUserNotificationCenter.current()
        
        notificationCenter.removeAllPendingNotificationRequests()
        
        let content = UNMutableNotificationContent()
        content.title = "오늘도 Anki와 함께 공부해봐요!"
        content.body = "터치하면 앱의 메인 화면으로 이동합니다."
        
        // Calendar 객체를 사용하여 현재 날짜의 요일 가져옴
        let calendar = Calendar.current
        let weekday = calendar.component(.weekday, from: Date())
        
        if 2...6 ~= weekday { // 월요일(2)부터 금요일(6)까지만 trigger
            let triggerDate = calendar.dateComponents([.hour, .minute], from: setting.reminderTime)
            
            let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: true)
            
            let request = UNNotificationRequest(
                identifier: "sendWeekdaysNoti",
                content: content,
                trigger: trigger
            )
            
            if setting.notificationOption != .none {
                notificationCenter.add(request) { (error) in
                    if error != nil {}
                }
            }
        }
    }

    func sendTestNoti() {
        let notificationCenter = UNUserNotificationCenter.current()
        
        notificationCenter.removeAllPendingNotificationRequests()
        
        // 1. 알림 내용 작성 -> content
        let content = UNMutableNotificationContent()
        content.title = "오늘도 Anki와 함께 공부해봐요!"
        content.body = "터치하면 앱의 메인 화면으로 이동합니다."
        
        // 2. 발동조건 작성 -> trigger / 토글 3초 후
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 3, repeats: false)
        //let trigger = UNCalendarNotificationTrigger(dateMatching: Calendar.current.dateComponents([.hour, .minute], from: setting.reminderTime), repeats: true)
        
        // 3. 요청 작성 -> request
        let request = UNNotificationRequest(
            identifier: "testNotification",
            content: content,
            trigger: trigger
        )
        
        if setting.notificationOption != .none {
            notificationCenter.add(request) { (error) in
                if let error = error {
                    print("sendTestNoti: 실패 \(error.localizedDescription)")
                } else {
                    print("sendTestNoti: 성공")
                }
            }
        }
    }
}
