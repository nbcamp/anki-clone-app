import EventBus
import UIKit

struct PushToSettingScreenEvent: EventProtocol {
    let payload: Void = ()
}

struct ShowCreateCellAlertEvent: EventProtocol {
    let payload: Void = ()
}

struct CellTappedEvent: EventProtocol {
    let payload: Void = ()
}

final class HomeViewController: RootViewController<HomeView> {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SettingService.shared.requestNotificationAuthorization() // 푸시알림 권한요청
        
        EventBus.shared.on(PushToSettingScreenEvent.self, by: self) { listener, _ in
            listener.navigationController?.pushViewController(SettingViewController(), animated: true)
        }

        EventBus.shared.on(ShowCreateCellAlertEvent.self, by: self) { listener, _ in
            listener.showCreateCellAlert()
        }

        EventBus.shared.on(CellTappedEvent.self, by: self) { listener, _ in
            listener.navigationController?.pushViewController(StudyViewController(), animated: true)
        }
    }

    private func showCreateCellAlert() {
        let alertController = UIAlertController(title: "단어장 추가하기", message: "단어장 이름을 작성해주세요.", preferredStyle: .alert)

        alertController.addTextField { textField in
            textField.placeholder = "단어장 이름"
        }

        let confirmAction = UIAlertAction(title: "추가", style: .default) { [weak self, weak alertController] _ in
            guard let deckTitle = alertController?.textFields?.first?.text, !deckTitle.isEmpty else {
                self?.showError(message: "텍스트가 비어있습니다.")
                return
            }

            // 새로운 DataModel 생성 및 배열에 추가
//            let newItem =
//            self?.rootView.decks.append(newItem)
//                self?.rootView.homeCollectionView.reloadData()
        }

        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)

        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)

        present(alertController, animated: true, completion: nil)
    }

    private func showError(message: String) {
        let errorAlert = UIAlertController(title: "에러", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인", style: .default, handler: nil)
        errorAlert.addAction(okAction)
        present(errorAlert, animated: true, completion: nil)
    }
}
