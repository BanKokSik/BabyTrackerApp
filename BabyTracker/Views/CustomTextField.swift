//
//  CustomTextField.swift
//  BabyTracker
//
//  Created by Мявкo on 21.07.23.
//

import UIKit

class CustomTextField: UITextField {

    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        if action == #selector(UIResponderStandardEditActions.paste) ||
            action == #selector(UIResponderStandardEditActions.cut) ||
            action == #selector(UIResponderStandardEditActions.copy) ||
            action == #selector(UIResponderStandardEditActions.select) ||
            action == #selector(UIResponderStandardEditActions.selectAll) {
            return false
        }
        else {
            return super.canPerformAction(action, withSender: sender)
        }
   }
}
