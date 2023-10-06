import UIKit

final class EditFlashCardView: UIView, RootView {
    var field: (front: String, back: String) {
        (frontTextField.text ?? "", backTextField.text ?? "")
    }

    private lazy var textFieldGroupView = {
        let textFieldGroupView = UIStackView(arrangedSubviews: [
            frontTextField,
            backTextField
        ])
        textFieldGroupView.axis = .vertical
        textFieldGroupView.spacing = 40
        textFieldGroupView.distribution = .fillEqually
        return textFieldGroupView
    }()

    private lazy var frontTextField = makeTextField(name: "카드 앞면")
    private lazy var backTextField = makeTextField(name: "카드 뒷면")

    private func makeTextField(name: String) -> UITextField {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.layer.borderWidth = 1.0
        textField.layer.cornerRadius = 10
        let label = {
            let label = UILabel()
            label.text = name
            label.font = .systemFont(ofSize: 14, weight: .bold)
            return label
        }()
        textField.addSubview(label)
        label.snp.makeConstraints { make in
            make.bottom.equalTo(textField.snp.top).offset(-5)
        }
        return textField
    }

    func initializeUI() {
        backgroundColor = .systemBackground

        addSubview(textFieldGroupView)
        textFieldGroupView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(40)
            make.horizontalEdges.equalToSuperview().inset(20)
        }
    }
}
