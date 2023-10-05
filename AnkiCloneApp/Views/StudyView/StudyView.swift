import EventBus
import SnapKit
import UIKit

final class StudyView: UIView, RootView {
    weak var deck: Deck? {
        didSet { currentIndex = 0 }
    }

    private var currentIndex: Int = -1 {
        didSet {
            guard let deck, !deck.studies.isEmpty else { return }
            currentFlashCard = deck.studies[currentIndex]
            statLabel.text = "\(currentIndex + 1) / \(deck.studies.count)"
        }
    }

    private var currentFlashCard: FlashCard? {
        didSet {
            guard let card = currentFlashCard else { return }
            flashCardView.configure(with: card)
            flashCardFullView.configure(with: card)
        }
    }

    private var isFlipped: Bool = false {
        didSet {
            UIView.transition(with: flashCardView, duration: 0.3, options: .transitionFlipFromLeft) { [weak self] in
                guard let self else { return }
                self.flashCardView.layer.opacity = isFlipped ? 0.0 : 1.0
                self.flipCardButton.layer.opacity = isFlipped ? 0.0 : 1.0
                self.remindButtonsView.layer.opacity = isFlipped ? 1.0 : 0.0
                self.flashCardFullView.layer.opacity = isFlipped ? 1.0 : 0.0
            }
        }
    }

    private lazy var statLabel = {
        let statLabel = UILabel()
        statLabel.text = "0 / 0"
        statLabel.textAlignment = .center
        statLabel.font = .systemFont(ofSize: 16, weight: .bold)
        return statLabel
    }()

    private lazy var flashCardView = {
        let flashCardView = FlashCardView()
        return flashCardView
    }()

    private lazy var flipCardButton = {
        let flipCardButton = UIButton(type: .system)
        flipCardButton.setTitle("정답 확인하기", for: .normal)
        flipCardButton.setTitleColor(UIColor.black, for: .normal)
        flipCardButton.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        flipCardButton.backgroundColor = .white
        flipCardButton.layer.cornerRadius = 10
        flipCardButton.layer.borderWidth = 0.5
        flipCardButton.layer.borderColor = UIColor.gray.cgColor
        flipCardButton.addTarget(self, action: #selector(flipCardButtonTapped), for: .touchUpInside)
        return flipCardButton
    }()

    private lazy var flashCardFullView = {
        let flashCardFullView = FlashCardFullView()
        flashCardFullView.layer.opacity = 0.0
        return flashCardFullView
    }()

    private lazy var remindButtonsView = {
        let remindButtonsView = RemindButtonsView()
        remindButtonsView.layer.opacity = 0.0
        remindButtonsView.buttonTapped = { [weak self] type in
            guard let self else { return }
            guard let flashCard = self.currentFlashCard else { return }
            EventBus.shared.emit(RemindFlashCardEvent(payload: .init(flashCard: flashCard, after: type.rawValue) {
                if self.currentIndex + 1 >= (self.deck?.studies.count ?? 0) {
                    remindButtonsView.isHidden = true
                    self.flipCardButton.isHidden = true
                    self.endStudyButton.isHidden = false
                } else {
                    self.currentIndex += 1
                    self.isFlipped = false
                }

            }))
        }
        return remindButtonsView
    }()

    private lazy var endStudyButton = {
        let endStudyButton = UIButton()
        endStudyButton.setTitle("공부 종료하기", for: .normal)
        endStudyButton.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        endStudyButton.tintColor = .systemGray6
        endStudyButton.backgroundColor = .label
        endStudyButton.layer.cornerRadius = 10
        endStudyButton.layer.masksToBounds = true
        endStudyButton.isHidden = true
        endStudyButton.addTarget(self, action: #selector(endStudyButtonTapped), for: .touchUpInside)
        return endStudyButton
    }()

    func initializeUI() {
        backgroundColor = .systemBackground

        addSubview(statLabel)
        statLabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(20)
            make.horizontalEdges.equalToSuperview().inset(20)
        }

        addSubview(flashCardView)
        flashCardView.snp.makeConstraints { make in
            make.top.equalTo(statLabel.snp.bottom).offset(20)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalToSuperview().multipliedBy(0.6)
        }

        addSubview(flipCardButton)
        flipCardButton.snp.makeConstraints { make in
            make.top.equalTo(flashCardView.snp.bottom).offset(20)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(50)
        }

        addSubview(flashCardFullView)
        flashCardFullView.snp.makeConstraints { make in
            make.top.equalTo(statLabel.snp.bottom).offset(20)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalToSuperview().multipliedBy(0.6)
        }

        addSubview(remindButtonsView)
        remindButtonsView.snp.makeConstraints { make in
            make.top.equalTo(flashCardView.snp.bottom).offset(20)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(50)
        }

        addSubview(endStudyButton)
        endStudyButton.snp.makeConstraints { make in
            make.top.equalTo(flashCardView.snp.bottom).offset(20)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(50)
        }
    }

    @objc func flipCardButtonTapped() {
        isFlipped = true
    }
    
    @objc func endStudyButtonTapped() {
        guard let viewController else { return }
        EventBus.shared.emit(PopViewControllerEvent(payload: .init(viewController: viewController)))
    }
}
