//
//  WordAnswerCardView.swift
//  AnkiCloneApp
//
//  Created by t2023-m0062 on 2023/10/02.
//

import UIKit

final class WordAnswerCardView: UIView {
    private let wordLabel: UILabel = {
        let label = UILabel()
        label.text = "Test"
        label.textColor = .black
        label.textAlignment = .center
        
        return label
    }()
    
    private let dividerView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        
        return view
    }()
    
    private let meanLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "Test"
        label.textColor = .black
        label.textAlignment = .center
        
        return label
    }()
    
    init(word: String, mean: String) {
        self.wordLabel.text = word
        self.meanLabel.text = mean
        super.init(frame: .zero)
        configureUI()

        addSubview(wordLabel)
        addSubview(dividerView)
        addSubview(meanLabel)
        
        wordLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(90)
            $0.centerX.equalToSuperview()
        }
        
        dividerView.snp.makeConstraints {
            $0.height.equalTo(1)
            $0.horizontalEdges.equalToSuperview().inset(30)
            $0.top.equalTo(wordLabel.snp.bottom).offset(70)
        }
        
        meanLabel.snp.makeConstraints {
            $0.top.equalTo(dividerView.snp.bottom).offset(70)
            $0.horizontalEdges.equalToSuperview().inset(20)
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
