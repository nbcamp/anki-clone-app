import UIKit
import EventBus

extension UIView {
    var name: String { String(describing: self) }
}

extension Int {
    func dateFromTimestamp() -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(self))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy.MM.dd"
        return dateFormatter.string(from: date)
    }
}
