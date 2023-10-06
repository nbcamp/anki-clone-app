import EventBus

struct MoveToEditFlashCardScreenEvent: EventProtocol {
    let payload: Void = ()
}

struct MoveToStudyScreenEvent: EventProtocol {
    struct Payload {
        let deck: Deck
    }

    let payload: Payload
}

final class DeckViewController: RootViewController<DeckView> {
    weak var deck: Deck? {
        didSet { if let deck { rootView.configure(with: deck) } }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = deck?.title

        EventBus.shared.on(MoveToEditFlashCardScreenEvent.self, by: self) { subscriber, _ in
            let flashCardVC = EditFlashCardViewController()
            flashCardVC.deck = subscriber.deck
            subscriber.navigationController?.pushViewController(flashCardVC, animated: true)
        }

        EventBus.shared.on(MoveToStudyScreenEvent.self, by: self) { subscriber, payload in
            let studyVC = StudyViewController()
            studyVC.deck = payload.deck
            subscriber.navigationController?.pushViewController(studyVC, animated: true)
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let deck {
            rootView.configure(with: deck)
        }
    }
}
