import SnapKit
import UIKit

final class SettingView: UIView, RootView {
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initializeUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
        let cell = UITableViewCell(style: .value1, reuseIdentifier: "cell")
        var config = cell.defaultContentConfiguration()
        
        switch indexPath.row {
        case 0:
            config.text = "알림 관리" // viewModel.title
            config.secondaryText = "매일" // viewModel.secondaryText
        case 1:
            config.text = "기본 리마인더 시간"
            config.secondaryText = "9:00 오전"
        case 2:
            let switchView = UISwitch()

            config.text = "앱 내 알림 표시"
            cell.accessoryView = switchView
        default:
            break
        }
        
        cell.contentConfiguration = config
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
}

extension SettingView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch indexPath.row {
        case 0:
            // Action Sheet
            break
        case 1:
            // Time Picker로 시간 업데이트
            break
        default:
            break
        }
    }
}
