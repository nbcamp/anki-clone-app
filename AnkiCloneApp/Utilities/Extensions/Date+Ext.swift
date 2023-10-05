import Foundation

extension Date {
    @available(iOS, obsoleted: 15.0)
    static var now: Date { .init() }

    var unixtime: UInt64 { .init(self.timeIntervalSince1970) }

    init(unixtime: UInt64) {
        self.init(timeIntervalSince1970: TimeInterval(unixtime))
    }

    func format(_ dateFormat: String = "yy.MM.dd") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        return dateFormatter.string(from: self)
    }
}
