import UIKit

class EditFlashCardView: UIView, RootView {
    private let textField1 = UITextField()
    private let textField2 = UITextField()
    private let frontlabel = UILabel()
    private let backlabel = UILabel()
    private let senterlabel = UILabel()
    private let deleteButton1 = UIButton(type: .system)
    private let addButton1 = UIButton(type: .system)
    
    func initializeUI() {
        
        // 삭제 버튼 설정
        deleteButton1.setTitle("X", for: .normal)
        addSubview(deleteButton1)
        
        senterlabel.text = "새 단어를 추가하세요."
        addSubview(senterlabel)
        
        // 추가 버튼 1 설정
        addButton1.setTitle("추가", for: .normal)
        addSubview(addButton1)
        
        // "앞면" 레이블 설정
        backgroundColor = .white
        frontlabel.text = "앞면"
        addSubview(frontlabel)
        
        // 입력 필드 1 설정
        textField1.placeholder = "여기에 입력해주세요."
        textField1.borderStyle = .roundedRect
        addSubview(textField1)
        
        // "뒷면" 레이블 설정
        backlabel.text = "뒷면"
        addSubview(backlabel)
        
        // 입력 필드 2 설정
        textField2.placeholder = "여기에 입력해주세요."
        textField2.borderStyle = .roundedRect
        addSubview(textField2)
        
        // 오토레이아웃 설정
        frontlabel.translatesAutoresizingMaskIntoConstraints = false
        deleteButton1.translatesAutoresizingMaskIntoConstraints = false
        textField1.translatesAutoresizingMaskIntoConstraints = false
        addButton1.translatesAutoresizingMaskIntoConstraints = false
        backlabel.translatesAutoresizingMaskIntoConstraints = false
        textField2.translatesAutoresizingMaskIntoConstraints = false
        senterlabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            
            deleteButton1.centerYAnchor.constraint(equalTo: topAnchor, constant: 100),//label1.centerYAnchor
            deleteButton1.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),//label1.trailingAnchor
            
            senterlabel.centerYAnchor.constraint(equalTo: topAnchor, constant: 100),
            senterlabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            
            addButton1.centerYAnchor.constraint(equalTo: deleteButton1.centerYAnchor),
            addButton1.leadingAnchor.constraint(equalTo: trailingAnchor, constant: -50),
            
            frontlabel.topAnchor.constraint(equalTo: deleteButton1.bottomAnchor, constant: 20),//safeAreaLayoutGuide.topAnchor
            frontlabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),//leadingAnchor
            
            textField1.topAnchor.constraint(equalTo: frontlabel.bottomAnchor, constant: 8),
            textField1.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            textField1.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            backlabel.topAnchor.constraint(equalTo: textField1.bottomAnchor, constant: 20),
            backlabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            
            textField2.topAnchor.constraint(equalTo: backlabel.bottomAnchor, constant: 8),
            textField2.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            textField2.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])
    }
}

