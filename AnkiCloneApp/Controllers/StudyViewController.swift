import EventBus

struct RemindFlashCardEvent: EventProtocol {
    struct Payload {
        let flashCard: FlashCard
        let after: Int
        let completionHandler: () -> Void
    }

    let payload: Payload
}

final class StudyViewController: RootViewController<StudyView> {
    weak var deck: Deck? { didSet { rootView.deck = deck } }

    override func viewDidLoad() {
        super.viewDidLoad()

        EventBus.shared.on(RemindFlashCardEvent.self, by: self as StudyViewController) { subscriber, payload in
            DeckService.shared.remind(payload.flashCard, after: .init(payload.after))
            payload.completionHandler()
        }
    }
}
