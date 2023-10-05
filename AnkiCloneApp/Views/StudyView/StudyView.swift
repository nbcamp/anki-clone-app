import SnapKit
import UIKit

final class StudyView: UIView, RootView {
    private var questionView: WordCardView = {
        let view = WordCardView(word: "단어")
        
        return view
    }()
    
    private var answerButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Tap to show answer", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        button.backgroundColor = .white
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 0.5
        button.layer.borderColor = UIColor.gray.cgColor
        
        return button
    }()
    
    private var answerView: WordAnswerCardView = {
        let view = WordAnswerCardView(word: "단어", mean: "뜻")
        view.layer.opacity = 0.0
        
        return view
    }()
    
    private var timeButton: TimeStackView = {
        let button = TimeStackView()
        button.isHidden = true
        
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //initializeUI() -> 호출 필요 없음. RootViewController에서 rootView.initializeUI() 해주고 있음
        addTarget()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initializeUI() {
        addSubViews()
        
        questionView.snp.makeConstraints { make in
            make.width.equalTo(330)
            make.height.equalTo(450)
            make.center.equalToSuperview()
        }
        
        answerButton.snp.makeConstraints{ make in
            make.width.equalTo(260)
            make.height.equalTo(50)
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom)
            make.centerX.equalToSuperview()
        }

        answerView.snp.makeConstraints { make in
            make.width.equalTo(330)
            make.height.equalTo(450)
            make.center.equalToSuperview()
        }
        
        timeButton.snp.makeConstraints { make in
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom)
            make.height.equalTo(50)
            make.horizontalEdges.equalToSuperview().inset(15)
        }
    }
    
    private func addSubViews() {
        [questionView, answerButton, answerView, timeButton].forEach {
            addSubview($0)
        }
    }
    
    private func addTarget() {
        answerButton.addTarget(self, action: #selector(didClickAnswerButton), for: .touchUpInside)
    }
    
    @objc func didClickAnswerButton() {
        UIView.transition(with: questionView, duration: 0.7, options: .transitionFlipFromLeft, animations: { [weak self] in
            self?.questionView.layer.opacity = 0.0
            self?.answerButton.isHidden = true
        }) { [weak self] _ in
            self?.timeButton.isHidden = false
            self?.answerView.layer.opacity = 1.0
        }
    }
}
