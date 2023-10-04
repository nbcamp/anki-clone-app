import Foundation
import Publishable

final class Deck: ViewModel {
    let id: String
    @Publishable var title: String
    @Publishable var flashCards: [FlashCard]
    let createdAt: UInt64

    var studies: [FlashCard] { flashCards.filter { !$0.memorized } }

    init(id: String? = nil, title: String, createdAt: UInt64? = nil, with flashCards: [FlashCard] = []) {
        self.id = id ?? UUID().uuidString
        self.title = title
        self.flashCards = flashCards
        self.createdAt = createdAt ?? Date.now.unixtime
    }
}

extension Deck {
    func toModel() -> DeckModel { .init(from: self) }
}

extension Deck {
    var createdDate: Date { .init(unixtime: createdAt) }
}
