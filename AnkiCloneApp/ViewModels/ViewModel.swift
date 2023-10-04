protocol ViewModel: Identifiable, Equatable {}

extension ViewModel {
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id
    }
}
