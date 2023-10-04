import UIKit
import EventBus

extension UIView {
    var name: String { String(describing: self) }
}

extension HomeView: UICollectionViewDelegate, UICollectionViewDataSource, CircleCellDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return decks.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = homeCollectionView.dequeueReusableCell(withReuseIdentifier: "circleCell", for: indexPath) as! CircleCell
        cell.delegate = self
        let deck = decks[indexPath.row]
                cell.configure(with: deck)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        EventBus.shared.emit(CellTappedEvent())
    }
    
    func didTapDeleteButton(in cell: CircleCell) {
        
        print("Delete button tapped")
        guard let indexPath = homeCollectionView.indexPath(for: cell) else { return }
        decks.remove(at: indexPath.row)
        homeCollectionView.deleteItems(at: [indexPath])
    }
}

extension Int {
    func dateFromTimestamp() -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(self))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy.MM.dd"
        return dateFormatter.string(from: date)
    }
}

