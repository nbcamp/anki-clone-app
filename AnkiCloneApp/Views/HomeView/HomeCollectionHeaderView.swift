import UIKit

final class HomeCollectionHeaderView: UICollectionReusableView {
    var settingButtonTapped: (() -> Void)?

    private lazy var titleLabel = {
        let titleLabel = UILabel()
        titleLabel.text = "덱 모음집"
        titleLabel.font = .systemFont(ofSize: 35, weight: .black)
        return titleLabel
    }()

    private lazy var settingButton: UIButton = {
        let button = UIButton(type: .system)
        let image = UIImage(systemName: "gearshape")?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 30, weight: .medium))
        button.setImage(image, for: .normal)
        button.tintColor = .black
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(didTapSettingButton), for: .touchUpInside)
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(30)
            make.height.equalTo(35)
            make.left.equalToSuperview()
        }

        addSubview(settingButton)
        settingButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(30)
            make.width.equalTo(35)
            make.height.equalTo(35)
            make.right.equalToSuperview()
        }
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc private func didTapSettingButton() {
        settingButtonTapped?()
    }
}
