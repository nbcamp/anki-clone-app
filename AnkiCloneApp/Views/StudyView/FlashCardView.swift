import UIKit

final class FlashCardView: UIView {
    private let frontLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .medium)
        label.textAlignment = .center
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        addSubview(frontLabel)
        frontLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with card: FlashCard) {
        frontLabel.text = card.front

        backgroundColor = .systemBackground
        layer.cornerRadius = 15

        // 그림자
        layer.masksToBounds = false
        layer.shadowColor = UIColor.lightGray.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowOpacity = 0.7 // 그림자 투명도
        layer.shadowRadius = 5 // 퍼지는 효과
    }
}
