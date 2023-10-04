struct FlashCardModel: Codable {
    let id: String
    let front: String
    let back: String
    let forgotAt: UInt64
    let createdAt: UInt64

    init(from flashCard: FlashCard) {
        id = flashCard.id
        front = flashCard.front
        back = flashCard.back
        forgotAt = flashCard.forgotAt
        createdAt = flashCard.createdAt
    }
}

extension FlashCardModel {
    func toViewModel(of deck: Deck) -> FlashCard? {
        .init(
            id: id,
            front: front,
            back: back,
            forgotAt: forgotAt,
            createdAt: createdAt,
            of: deck
        )
    }
}
