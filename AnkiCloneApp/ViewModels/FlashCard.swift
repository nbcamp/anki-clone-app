import Foundation

final class FlashCard: ViewModel {
    let id: String
    var front: String
    var back: String
    let createdAt: UInt64

    unowned var deck: Deck

    init(id: String? = nil, front: String, back: String, createdAt: UInt64? = nil, of deck: Deck) {
        self.id = id ?? UUID().uuidString
        self.front = front
        self.back = back
        self.deck = deck
        self.createdAt = createdAt ?? Date.now.unixtime
    }
}

extension FlashCard {
    func toModel() -> FlashCardModel { .init(from: self) }
}

extension FlashCard {
    var createdDate: Date { .init(unixtime: createdAt) }
}
