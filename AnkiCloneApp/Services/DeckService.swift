import Foundation

final class DeckService {
    static let shared: DeckService = .init()
    private init() {}

    private(set) var decks: [Deck] = []

    private lazy var key = String(describing: self)
    var storage: Storage? { didSet { decks = load() } }

    func create(deck: Deck) {
        decks.append(deck)
        save(decks: decks)
    }

    func create(card: FlashCard) {
        card.deck.flashCards.append(card)
        save(decks: decks)
    }

    func remind(_ flashCard: FlashCard, after: TimeInterval) {
        flashCard.forgotAt += .init(after)
        save(decks: decks)
    }

    private func save(decks: [Deck]) {
        storage?.save(decks.map { $0.toModel() }, forKey: key)
    }

    private func load() -> [Deck] {
        guard let models: [DeckModel] = storage?.load(forKey: key) else { return [] }
        return models.compactMap { $0.toViewModel() }
    }
}
