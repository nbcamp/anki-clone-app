//
//  WordAnswerCardView.swift
//  AnkiCloneApp
//
//  Created by t2023-m0062 on 2023/10/02.
//

import UIKit

final class FlashCardFullView: UIView {
    private let frontLabel: UILabel = {
        let frontLabel = UILabel()
        frontLabel.font = .systemFont(ofSize: 16, weight: .medium)
        frontLabel.textAlignment = .center
        return frontLabel
    }()

    private let dividerView: UIView = {
        let dividerView = UIView()
        dividerView.backgroundColor = .systemGray3
        return dividerView
    }()

    private let backLabel: UILabel = {
        let backLabel = UILabel()
        backLabel.font = .systemFont(ofSize: 20, weight: .medium)
        backLabel.numberOfLines = 0
        backLabel.textAlignment = .center
        return backLabel
    }()
    
    func configure(with card: FlashCard) {
        frontLabel.text = card.front
        backLabel.text = card.back
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .systemBackground
        layer.cornerRadius = 15

        layer.masksToBounds = false
        layer.shadowColor = UIColor.lightGray.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowOpacity = 0.7 //그림자 투명도
        layer.shadowRadius = 5  //퍼지는 효과
        
        addSubview(frontLabel)
        frontLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(90)
            $0.centerX.equalToSuperview()
        }

        addSubview(dividerView)
        dividerView.snp.makeConstraints {
            $0.height.equalTo(1)
            $0.horizontalEdges.equalToSuperview().inset(30)
            $0.top.equalTo(frontLabel.snp.bottom).offset(50)
        }

        addSubview(backLabel)
        backLabel.snp.makeConstraints {
            $0.top.equalTo(dividerView.snp.bottom).offset(70)
            $0.horizontalEdges.equalToSuperview().inset(20)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
