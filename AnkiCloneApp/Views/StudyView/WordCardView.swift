//
//  WordCardView.swift
//  AnkiCloneApp
//
//  Created by t2023-m0062 on 2023/10/02.
//

import UIKit

final class WordCardView: UIView {
    let wordLabel: UILabel = {
        let label = UILabel()
        label.text = "Test"
        label.textColor = .black
        label.textAlignment = .center
        
        return label
    }()
    
    init(word: String) {
        self.wordLabel.text = word
        super.init(frame: .zero)
        configureUI()

        addSubview(wordLabel)
        
        wordLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    private func configureUI() {
        self.backgroundColor = .white
        self.layer.cornerRadius = 15
        
        //그림자
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowOffset = CGSize(width: 2, height: 2)
        self.layer.shadowOpacity = 0.7 //그림자 투명도
        self.layer.shadowRadius = 5  //퍼지는 효과
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
