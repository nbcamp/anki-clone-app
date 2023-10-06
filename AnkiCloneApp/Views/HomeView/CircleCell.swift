import UIKit

class CircleCell: UICollectionViewCell {
    var deleteButtonTapped: ((_ cell: CircleCell) -> Void)?

    private lazy var progressView = {
        let progressView = CircularProgressView()
        progressView.delegate = self
        progressView.size = 140
        progressView.draw()
        return progressView
    }()

    private lazy var progressRateLabel = {
        let progressRateLabel = UILabel()
        progressRateLabel.text = "0%"
        progressRateLabel.font = .systemFont(ofSize: 32, weight: .bold)
        return progressRateLabel
    }()

    private lazy var deleteButton = {
        let button = UIButton(type: .system)
        let trashImage = UIImage(systemName: "trash") // 쓰레기통 아이콘
        button.setImage(trashImage, for: .normal)
        button.tintColor = .label
        button.transform = .init(scaleX: 0.6, y: 0.6)
        button.addTarget(self, action: #selector(handleDelete), for: .touchUpInside)
        return button
    }()

    private lazy var titleLabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        return label
    }()

    private lazy var createdLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .systemGray
        label.font = UIFont.systemFont(ofSize: 14, weight: .light)
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        addSubview(progressView)
        progressView.snp.makeConstraints { make in
            make.width.equalTo(140)
            make.height.equalTo(140)
        }

        addSubview(deleteButton)
        deleteButton.snp.makeConstraints { make in
            make.centerX.equalTo(progressView)
            make.centerY.equalTo(progressView).offset(40)
        }

        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(progressView.snp.bottom).offset(14)
            make.centerX.equalToSuperview()
        }

        addSubview(createdLabel)
        createdLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom)
            make.centerX.equalToSuperview()
        }
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        progressView.progress(0, animated: false)
    }

    func configure(with deck: Deck) {
        let rate = deck.rate
        titleLabel.text = deck.title
        createdLabel.text = deck.createdDate.format()
        progressRateLabel.text = "\(Int(rate * 100))%"
        progressView.progress(.init(rate), animated: false)
    }

    @objc private func handleDelete() {
        deleteButtonTapped?(self)
    }
}

extension CircleCell: CircularProgressViewDelegate {
    func innerView(_ view: UIView) {
        view.addSubview(progressRateLabel)
        progressRateLabel.snp.makeConstraints { make in
            make.center.equalTo(view)
        }
    }
}
