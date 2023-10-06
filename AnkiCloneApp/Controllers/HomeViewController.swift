import EventBus
import UIKit

struct MoveToSettingScreenEvent: EventProtocol {
    let payload: Void = ()
}

struct ShowCreateNewDeckAlertEvent: EventProtocol {
    let payload: (String) -> Void
}

struct MoveToDeckScreenEvent: EventProtocol {
    struct Payload {
        let deck: Deck
    }
    
    let payload: Payload
}

struct ShowDeleteDeckAlertEvent: EventProtocol {
    struct Payload {
        let deck: Deck
        let completionHandler: () -> Void
    }

    let payload: Payload
}

final class HomeViewController: RootViewController<HomeView> {
    override func viewDidLoad() {
        super.viewDidLoad()
        rootView.configure(with: DeckService.shared.decks)
        SettingService.shared.requestNotificationAuthorization() // 푸시알림 권한요청

        EventBus.shared.on(MoveToSettingScreenEvent.self, by: self) { listener, _ in
            listener.navigationController?.pushViewController(SettingViewController(), animated: true)
        }

        EventBus.shared.on(ShowCreateNewDeckAlertEvent.self, by: self) { listener, payload in
            listener.showCreateCellAlert(completion: payload)
        }

        EventBus.shared.on(MoveToDeckScreenEvent.self, by: self) { listener, payload in
            let deckVC = DeckViewController()
            deckVC.deck = payload.deck
            listener.navigationController?.pushViewController(deckVC, animated: true)
        }

        EventBus.shared.on(ShowDeleteDeckAlertEvent.self, by: self) { listener, payload in
            listener.showDeleteDeckAlert(deck: payload.deck, completion: payload.completionHandler)
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
        rootView.configure(with: DeckService.shared.decks)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.isNavigationBarHidden = false
    }

    private func showCreateCellAlert(completion: @escaping (String) -> Void) {
        let alertController = UIAlertController(title: "덱 추가", message: "생성할 덱 이름을 작성해주세요.", preferredStyle: .alert)

        alertController.addTextField { textField in
            textField.placeholder = "새로운 덱 이름"
        }

        let confirmAction = UIAlertAction(title: "추가", style: .default) { [weak self, weak alertController] _ in
            guard let deckTitle = alertController?.textFields?.first?.text, !deckTitle.isEmpty else {
                self?.showError(message: "텍스트가 비어있습니다.")
                return
            }

            DeckService.shared.create(deck: .init(title: deckTitle))
            self?.rootView.configure(with: DeckService.shared.decks)
            completion(deckTitle)
        }

        let cancelAction = UIAlertAction(title: "취소", style: .cancel)
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true)
    }

    private func showDeleteDeckAlert(deck: Deck, completion: @escaping () -> Void) {
        let alert = UIAlertController(title: nil, message: "삭제하시겠습니까?", preferredStyle: .alert)
        let deleteAction = UIAlertAction(title: "삭제", style: .destructive) { [weak self] _ in
            DeckService.shared.remove(deck: deck)
            self?.rootView.configure(with: DeckService.shared.decks)
            completion()
        }
        let cancelAction = UIAlertAction(title: "취소", style: .cancel)
        alert.addAction(deleteAction)
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }

    private func showError(message: String) {
        let errorAlert = UIAlertController(title: "에러", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인", style: .default, handler: nil)
        errorAlert.addAction(okAction)
        present(errorAlert, animated: true, completion: nil)
    }
}
