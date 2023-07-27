//
//  OnBoardingViewController.swift
//  BabyTracker
//
//  Created by Мявкo on 28.06.23.
//

import UIKit

class PageCell: UICollectionViewCell {
    
    static let reuseIdentifier = "PageCell"
    
    private lazy var imageView: UIImageView = _imageView
    private lazy var textLabel: UILabel = _textLabel
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        
        setupSubviews()
        applyConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSubviews() {
        addSubview(imageView)
        addSubview(textLabel)
    }
    
    private func applyConstraints() {
        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(70)
            make.leading.trailing.equalToSuperview().inset(30)
            make.height.equalTo(555)
        }
        
        textLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(52)
            make.leading.trailing.equalToSuperview().inset(60)
        }
    }
    
    func update(image: UIImage, text: String) {
        imageView.image = image
        textLabel.text = text
    }
}

private extension PageCell {
    
    var _imageView: UIImageView {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        return imageView
    }
    
    var _textLabel: UILabel {
        let label = UILabel()
        label.font = Fonts.gilroySemiBold18
        label.textColor = .black
        label.textAlignment = .center
        return label
    }
    
}
