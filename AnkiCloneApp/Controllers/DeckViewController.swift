import EventBus

struct PresentEditFlashCardScreenEvent: EventProtocol {
    let payload: Void = ()
}

struct PushToStudyScreenEvent: EventProtocol {
    let payload: Void = ()
}

final class DeckViewController: RootViewController<DeckView> {
    weak var deck: Deck? {
        didSet { if let deck { rootView.configure(with: deck) } }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = deck?.title

        EventBus.shared.on(PresentEditFlashCardScreenEvent.self, by: self) { subscriber, _ in
            // TODO: 아래 코드로 대체 필요
//            subscriber.present(<#T##viewControllerToPresent: UIViewController##UIViewController#>, animated: true)
            guard let deck = subscriber.deck else { return }
            DeckService.shared.create(card: .init(front: "Front", back: "Back", of: deck))
            subscriber.rootView.configure(with: deck)
        }

        EventBus.shared.on(PushToStudyScreenEvent.self, by: self) { subscriber, _ in
            let studyVC = StudyViewController()
            subscriber.navigationController?.pushViewController(studyVC, animated: true)
        }
    }
}