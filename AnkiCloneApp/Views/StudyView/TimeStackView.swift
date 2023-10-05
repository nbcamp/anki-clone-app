//
//  TimeStackView.swift
//  AnkiCloneApp
//
//  Created by t2023-m0062 on 2023/10/02.
//

import UIKit

final class TimeStackView: UIStackView {
    private let againBtn: UIButton = {
        let button = UIButton()
        button.titleLabel?.lineBreakMode = .byCharWrapping
        button.setTitle("Again \n < 1m", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        button.backgroundColor = .systemGray4
        button.layer.cornerRadius = 10
        
        return button
    }()
    
    private let hardBtn: UIButton = {
        let button = UIButton()
        button.titleLabel?.lineBreakMode = .byCharWrapping
        button.setTitle("Hard \n8m", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        button.backgroundColor = .systemGray4
        button.layer.cornerRadius = 10
        
        return button
    }()
    
    private let goodBtn: UIButton = {
        let button = UIButton()
        button.titleLabel?.lineBreakMode = .byCharWrapping
        button.setTitle("Good\n15m", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        button.backgroundColor = .systemGray4
        button.layer.cornerRadius = 10
        
        return button
    }()
    
    private let easyBtn: UIButton = {
        let button = UIButton()
        button.titleLabel?.lineBreakMode = .byCharWrapping
        button.setTitle("Easy \n4d", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        button.backgroundColor = .systemGray4
        button.layer.cornerRadius = 10
        
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubViews()
        
        self.distribution = .fillEqually
        self.spacing = 10
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubViews() {
        [againBtn,hardBtn,goodBtn,easyBtn].forEach {
            self.addArrangedSubview($0)
        }
    }
    
}
