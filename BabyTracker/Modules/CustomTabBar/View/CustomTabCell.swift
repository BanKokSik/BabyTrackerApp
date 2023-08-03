//
//  CustomTabCell.swift
//  BabyTracker
//
//  Created by Мявкo on 3.08.23.
//

import UIKit

class CustomTabCell: UICollectionViewCell {
    
    static let cellIdentifier = R.string.localizable.tabCellIdentifier()
    
    private lazy var imageView: UIImageView = _imageView
    private lazy var shadowLayer: CALayer = _shadowLayer

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
        applyConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupSubviews() {
        layer.addSublayer(shadowLayer)
        addSubview(imageView)
    }
    
    private func applyConstraints() {
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.width.equalTo(71)
        }
    }
    
    func updateCell(isSelected: Bool) {
        imageView.alpha = isSelected ? 1.0 : 0.5
    }
    
    func setImage(_ image: UIImage?) {
        imageView.image = image
    }
}

extension CustomTabCell {
    
    var _imageView: UIImageView {
        let imageView = UIImageView()
        imageView.contentMode = .center
        imageView.clipsToBounds = false
        return imageView
   }
    
    var _shadowLayer: CALayer {
        let layer = CALayer()
        layer.frame = bounds
        layer.backgroundColor = UIColor.white.cgColor
        layer.cornerRadius = 10
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOpacity = 0.1
        layer.shadowRadius = 15
        return layer
    }
}
