struct DeckModel: Codable {
    let id: String
    let title: String
    let flashCards: [FlashCardModel]
    let createdAt: UInt64

    init(from deck: Deck) {
        id = deck.id
        title = deck.title
        flashCards = deck.flashCards.map(FlashCardModel.init)
        createdAt = deck.createdAt
    }
}

extension DeckModel {
    func toViewModel() -> Deck {
        let deck = Deck(
            id: id,
            title: title,
            createdAt: createdAt
        )
        deck.flashCards = flashCards.compactMap { $0.toViewModel(of: deck) }
        return deck
    }
}
