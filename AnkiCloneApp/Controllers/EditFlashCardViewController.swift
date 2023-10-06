import EventBus
import UIKit

struct CreateNewDeckEvent: EventProtocol {
    struct Payload {
        let front: String
        let back: String
    }

    let payload: Payload
}

final class EditFlashCardViewController: RootViewController<EditFlashCardView> {
    weak var deck: Deck?

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "새로운 카드 생성"

        navigationItem.leftBarButtonItem = .init(image: .init(systemName: "chevron.left"), style: .plain, target: self, action: #selector(backButtonTapped))
        navigationItem.rightBarButtonItem = .init(title: "추가", style: .done, target: self, action: #selector(doneButtonTapped))

        EventBus.shared.on(CreateNewDeckEvent.self, by: self) { subscriber, payload in
            guard let deck = subscriber.deck else { return }
            DeckService.shared.create(card: .init(front: payload.front, back: payload.back, of: deck))
        }
    }

    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }

    @objc func doneButtonTapped() {
        guard let deck else { return backButtonTapped() }
        let (front, back) = rootView.field
        guard !front.isEmpty else { return showAlert(message: "앞면 내용을 작성해주세요.") }
        guard !back.isEmpty else { return showAlert(message: "뒷면 내용을 작성해주세요.") }
        DeckService.shared.create(card: .init(front: front, back: back, of: deck))
        backButtonTapped()
    }

    private func showAlert(message: String) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(.init(title: "확인", style: .default))
        present(alert, animated: true)
    }
}
