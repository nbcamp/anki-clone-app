import Foundation

final class FlashCard: ViewModel {
    let id: String
    var front: String
    var back: String
    var forgotAt: UInt64
    let createdAt: UInt64

    unowned var deck: Deck

    var memorized: Bool { forgotAt > Date.now.unixtime }

    init(id: String? = nil, front: String, back: String, forgotAt: UInt64? = nil, createdAt: UInt64? = nil, of deck: Deck) {
        self.id = id ?? UUID().uuidString
        self.front = front
        self.back = back
        self.deck = deck
        self.forgotAt = forgotAt ?? Date.now.unixtime
        self.createdAt = createdAt ?? Date.now.unixtime
    }
}

extension FlashCard {
    func toModel() -> FlashCardModel { .init(from: self) }
}

extension FlashCard {
    var forgotDate: Date { .init(unixtime: forgotAt) }
    var createdDate: Date { .init(unixtime: createdAt) }
}
