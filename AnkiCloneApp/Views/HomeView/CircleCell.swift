//
//  CircleCell.swift
//  AnkiCloneApp
//
//  Created by t2023-m0075 on 2023/09/30.
//

import UIKit

class CircleCell: UICollectionViewCell {
    
    let circleImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "book")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.borderWidth = 10
        imageView.layer.borderColor = UIColor.black.cgColor
        imageView.layer.cornerRadius = 70
        imageView.clipsToBounds = true
        return imageView
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 25)
        return label
    }()
    
    let createdLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(circleImageView)
        addSubview(titleLabel)
        addSubview(createdLabel)
        
        circleImageView.frame = CGRect(x: 0, y: 0, width: 150, height: 150)
        titleLabel.frame = CGRect(x: 0, y: 160, width: self.bounds.width, height: 20)
        createdLabel.frame = CGRect(x: 0, y: frame.size.height - 30, width: frame.size.width, height: 20) // 높이는 원하는 값으로 조정
        
        bringSubviewToFront(circleImageView)
    }
    
    func configure(with model: DeckModel) {
        titleLabel.text = model.title
        createdLabel.text = model.createdAt.dateFromTimestamp()
    }
    
    private func setupCell() {
        backgroundColor = .clear
        
    }
    
}
