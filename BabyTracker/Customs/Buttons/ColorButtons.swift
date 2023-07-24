//
//  ColorButtons.swift
//  BabyTracker
//
//  Created by Мявкo on 11.07.23.
//

import UIKit

class PurpleButton: BaseButton {
    
    init(frame: CGRect, title: String) {
        super.init(frame: frame)
        setTitle(title, for: .normal)
        setBackgroundColor(R.color.heliotrope(), for: .normal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class BlackButton: BaseButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setBackgroundColor(R.color.black(), for: .normal)
        setTitle(R.string.localizable.logInWithAppleButton(), for: .normal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class WhiteButton: BaseButton {
    
    var customView: BorderView = {
        let view = BorderView()
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        return view
    }()
    
    var hasDashedBorder: Bool {
        didSet {
            setDashedBorder()
        }
    }
    
    let attributes: [NSAttributedString.Key: Any] = [
        .underlineStyle: NSUnderlineStyle.single.rawValue,
        .underlineColor: UIColor.red,  // Цвет пунктирной линии
    ]
    let attributeString: NSAttributedString
    
    override init(frame: CGRect) {
        attributeString = NSMutableAttributedString(
            string: R.string.localizable.restoreFromTheCloudButton(),
            attributes: attributes
        )
        hasDashedBorder = false
        super.init(frame: frame)
        layer.borderWidth = 1
        layer.borderColor = UIColor.white.cgColor
        setBackgroundColor(R.color.white(), for: .normal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setDashedBorder() {
        customView.addSubview(self)
        layoutCustomView()
        switch hasDashedBorder {
        case true:
            customView.isActive = .active
            customView.setNeedsDisplay()
        case false:
            customView.isActive = .inactive
            customView.setNeedsDisplay()
        }
    }
    
    func layoutCustomView() {
        customView.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.width.equalTo(318)
            make.height.equalTo(72)
        }
    }
}
