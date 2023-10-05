import UIKit

enum RemindButtonType: Int {
    case again = 0
    case hard = 480 // 60 * 8
    case good = 900 // 60 * 15
    case easy = 345_600 // 60 * 60 * 24 * 4
}

final class RemindButtonsView: UIStackView {
    var buttonTapped: ((_ type: RemindButtonType) -> Void)?

    class Button: UIButton {
        let type: RemindButtonType

        init(type: RemindButtonType) {
            self.type = type
            super.init(frame: .zero)
        }

        @available(*, unavailable)
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }

    private lazy var againButton: UIButton = {
        let button = Button(type: .again)
        button.titleLabel?.lineBreakMode = .byCharWrapping
        button.setTitle("다시", for: .normal)
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.font = UIFont.systemFont(ofSize: 13, weight: .bold)
        button.backgroundColor = .systemGray.withAlphaComponent(0.9)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(typedButtonTapped), for: .touchUpInside)
        return button
    }()

    private lazy var hardButton: UIButton = {
        let button = Button(type: .hard)
        button.titleLabel?.lineBreakMode = .byCharWrapping
        button.setTitle("어려움 \n8분", for: .normal)
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.font = UIFont.systemFont(ofSize: 13, weight: .bold)
        button.backgroundColor = .systemRed.withAlphaComponent(0.9)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(typedButtonTapped), for: .touchUpInside)
        return button
    }()

    private lazy var goodButton: UIButton = {
        let button = Button(type: .good)
        button.titleLabel?.lineBreakMode = .byCharWrapping
        button.setTitle("좋음 \n15분", for: .normal)
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.font = UIFont.systemFont(ofSize: 13, weight: .bold)
        button.backgroundColor = .systemTeal.withAlphaComponent(0.9)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(typedButtonTapped), for: .touchUpInside)
        return button
    }()

    private lazy var easyButton: UIButton = {
        let button = Button(type: .easy)
        button.titleLabel?.lineBreakMode = .byCharWrapping
        button.setTitle("쉬움 \n4일", for: .normal)
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.font = UIFont.systemFont(ofSize: 13, weight: .bold)
        button.backgroundColor = .systemGreen
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(typedButtonTapped), for: .touchUpInside)
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        addArrangedSubview(againButton)
        addArrangedSubview(hardButton)
        addArrangedSubview(goodButton)
        addArrangedSubview(easyButton)

        distribution = .fillEqually
        spacing = 10
    }

    @available(*, unavailable)
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc func typedButtonTapped(_ button: Button) {
        buttonTapped?(button.type)
    }
}
