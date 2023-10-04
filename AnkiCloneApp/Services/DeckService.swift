final class DeckService {
    static let shared: DeckService = .init()
    private init() {}

    private(set) var decks: [Deck] = [] {
        didSet { save(decks: decks) }
    }

    private lazy var key = String(describing: self)
    var storage: Storage? { didSet { decks = load() } }

    private func save(decks: [Deck]) {
        storage?.save(decks.map { $0.toModel() }, forKey: key)
    }

    private func load() -> [Deck] {
        guard let models: [DeckModel] = storage?.load(forKey: key) else { return [] }
        return models.compactMap { $0.toViewModel() }
    }
}
