//
//  BaseButton.swift
//  BabyTracker
//
//  Created by Мявкo on 11.07.23.
//

import UIKit
import SnapKit

enum ButtonState {
    case active
    case inactive
}

class BaseButton: UIButton {
    
    var buttonState: ButtonState = .active {
        didSet {
            updateButtonAppearance()
        }
    }
    
    func setSize(width: Int, height: Int) {
        frame = CGRect(x: 0, y: 0, width: width, height: height)
    }
    
    private func updateButtonAppearance() {
        switch buttonState {
        case .active:
            backgroundColor = R.color.heliotrope()
            isEnabled = true
        case .inactive:
            backgroundColor = R.color.mauve()
            isEnabled = false
        }
    }
}
