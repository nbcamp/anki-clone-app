import EventBus
import SnapKit
import UIKit

final class DeckView: UIView, RootView {
    private lazy var progressView = {
        let progressView = CircularProgressView()
        progressView.delegate = self
        progressView.size = 200
        progressView.draw()
        return progressView
    }()

    private lazy var progressRateLabel = {
        let progressRateLabel = UILabel()
        progressRateLabel.text = "0%"
        progressRateLabel.font = .systemFont(ofSize: 40, weight: .black)
        return progressRateLabel
    }()

    private lazy var statLabel = {
        let statLabel = UILabel()
        statLabel.font = .systemFont(ofSize: 20, weight: .bold)
        return statLabel
    }()

    private lazy var addCardButton = {
        let addCardButton = UIButton()
        addCardButton.setTitle("단어 추가하기", for: .normal)
        addCardButton.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        addCardButton.tintColor = .systemGray6
        addCardButton.backgroundColor = .label
        addCardButton.layer.cornerRadius = 10
        addCardButton.layer.masksToBounds = true
        addCardButton.contentEdgeInsets = .init(top: 5, left: 10, bottom: 5, right: 10)
        addCardButton.addTarget(self, action: #selector(addFlashCardButtonTapped), for: .touchUpInside)
        return addCardButton
    }()

    private lazy var startButton = {
        let startButton = UIButton()
        startButton.setTitle("공부 시작하기", for: .normal)
        startButton.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        startButton.tintColor = .systemGray6
        startButton.backgroundColor = .label
        startButton.layer.cornerRadius = 10
        startButton.layer.masksToBounds = true
        startButton.addTarget(self, action: #selector(startStudyButtonTapped), for: .touchUpInside)
        return startButton
    }()

    func configure(with deck: Deck) {
        let rate = deck.rate
        progressRateLabel.text = "\(Int(rate * 100))%"
        statLabel.text = if deck.isEmpty { "새로운 단어를 추가해주세요!" }
        else if deck.isCompleted { "모든 학습을 완료했습니다!" }
        else { "\(deck.flashCards.count)개의 카드 중 \(deck.studies.count)개의 학습이 필요합니다." }

        startButton.layer.opacity = deck.isEmpty ? 0.2 : 1.0
        startButton.isUserInteractionEnabled = !deck.isEmpty

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { [weak self] in
            self?.progressView.progress = .init(rate)
        }
    }

    func initializeUI() {
        backgroundColor = .systemBackground

        addSubview(progressView)
        progressView.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(40)
            make.centerX.equalTo(self)
            make.width.equalTo(200)
            make.height.equalTo(200)
        }

        addSubview(statLabel)
        statLabel.snp.makeConstraints { make in
            make.top.equalTo(progressView.snp.bottom).offset(20)
            make.centerX.equalTo(self)
        }

        addSubview(addCardButton)
        addCardButton.snp.makeConstraints { make in
            make.top.equalTo(statLabel.snp.bottom).offset(20)
            make.centerX.equalTo(self)
        }

        addSubview(startButton)
        startButton.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.leading.equalTo(self).offset(20)
            make.trailing.equalTo(self).offset(-20)
            make.bottom.equalTo(self.safeAreaLayoutGuide).offset(-20)
        }
    }

    @objc private func addFlashCardButtonTapped() {
        EventBus.shared.emit(PresentEditFlashCardScreenEvent())
    }

    @objc private func startStudyButtonTapped() {
        EventBus.shared.emit(PushToStudyScreenEvent())
    }
}

extension DeckView: CircularProgressViewDelegate {
    func innerView(_ view: UIView) {
        view.addSubview(progressRateLabel)
        progressRateLabel.snp.makeConstraints { make in
            make.center.equalTo(view)
        }
    }
}
