import SnapKit
import EventBus
import UIKit

final class SettingView: UIView, RootView {
    var setting: SettingViewModel?
    
    private lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        
        titleLabel.text = "푸시 알림"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 19)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return titleLabel
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.tableFooterView = UIView()
        
        return tableView
    }()
    
    private lazy var datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        
        datePicker.datePickerMode = .time
        datePicker.locale = Locale(identifier: "ko_KR")
        datePicker.date = SettingService.shared.setting.reminderTime // 현재 reminderTime
        datePicker.minuteInterval = 15 // 15분으로 할거면 디폴트 리마인더 타임을 9:00 으로 수정해야함
        
        datePicker.addTarget(self, action: #selector(datePickerValueChanged(_:)), for: .valueChanged)

        return datePicker
    }()
    
    func initializeUI() {
        backgroundColor = .systemBackground
        
        addSubview(titleLabel)
        addSubview(tableView)
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(19)
            make.leading.equalToSuperview().offset(19)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
}

extension SettingView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 1 {
            let cell = UITableViewCell(style: .default, reuseIdentifier: "datePickerCell")
            
            cell.contentView.addSubview(datePicker)
            
            datePicker.snp.makeConstraints { make in
                make.centerY.equalToSuperview()
                make.right.equalToSuperview().offset(-16)
            }

            cell.textLabel?.text = setting?.reminderTimeTitle
            cell.detailTextLabel?.text = setting?.reminderTimeSecondaryText
            
            return cell
        } else {
            let cell = UITableViewCell(style: .value1, reuseIdentifier: "cell")
            var config = cell.defaultContentConfiguration()
            
            switch indexPath.row {
            case 0:
                config.text = setting?.notificationOptionTitle
                config.secondaryText = setting?.notificationOptionSecondaryText
            case 2:
                let switchView = UISwitch()
                
                config.text = setting?.showInAppNotificationsTitle
                switchView.isOn = setting?.isShowInAppNotifications ?? false
                cell.accessoryView = switchView
                
                switchView.addTarget(self, action: #selector(switchValueChanged(_:)), for: .valueChanged)
            default:
                break
            }
            
            cell.contentConfiguration = config
            cell.accessoryType = .disclosureIndicator
            
            return cell
        }
    }
    
    @objc private func datePickerValueChanged(_ sender: UIDatePicker) {
        EventBus.shared.emit(DatePickerValueChangedEvent(payload: sender.date))
    }
    
    @objc private func switchValueChanged(_ sender: UISwitch) {
        EventBus.shared.emit(SwitchValueChangedEvent(payload: sender.isOn))
    }
}

extension SettingView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch indexPath.row {
        case 0:
            // Action Sheet
            EventBus.shared.emit(ShowNotificationManagementActionEvent(payload: .init(completionHandler: { [weak self] in
                self?.tableView.reloadData()
            })))
            break
        case 1:
            break
        default:
            break
        }
    }
}
