//
//  RegistrationPageViewController.swift
//  BabyTracker
//
//  Created by Мявкo on 11.07.23.
//

import UIKit
import SnapKit

protocol ViewControllerDelegate: AnyObject {}

enum ElementActivity {
    case active
    case inactive
}

class RegistrationPageViewController: UIViewController, UITextFieldDelegate {
    
    private lazy var viewContainer: UICustomView = _viewContainer
    private lazy var textField: UITextField = _textField
    private lazy var buttonClick: WhiteButton = _buttonClick
    private lazy var placeholderLabel: UILabel = _placeholderLabel

    var blurView: UIVisualEffectView?
    weak var delegate: ViewControllerDelegate?
    
    private var popupVC = PopupViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        textField.delegate = self
        popupVC.delegateRegistration = self
        
        layout()
    }
    
    func makeBackgroundBlur() {
        let blurEffect = UIBlurEffect(style: .systemUltraThinMaterialLight)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.backgroundColor = UIColor.magenta.withAlphaComponent(0.06)
        blurView.frame = view.bounds
        view.addSubview(blurView)
        
        self.blurView = blurView
    }

    func removeBackgroundBlur() {
        blurView?.removeFromSuperview()
    }
    
    @objc func showPopup() {
        makeBackgroundBlur()
        
        popupVC.view.center = view.center
        popupVC.blurView = blurView

        view.addSubview(popupVC.view)

        popupVC.view.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        popupVC.view.alpha = 0.0
        UIView.animate(withDuration: 0.2) { [self] in
            popupVC.view.transform = CGAffineTransform.identity
            popupVC.view.alpha = 1.0
        }
    }
    
    // Метод, который срабатывает, если нажать на кнопку (т.е. активность пропадает поля)
    @objc func buttonTap() {
        textField.resignFirstResponder()
        //buttonClick.customView.isActive = .active
        viewContainer.isActive = .active
        viewContainer.setNeedsDisplay()
    }
    
    // Метод, который срабатывает, если нажать на любое место внутри ViewController
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        textField.resignFirstResponder() // Скрыть клавиатуру и сделать текстовое поле неактивным
    }
    
    // Метод, который срабатывает, если на клавиатуре нажать кнопку Return
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    // Метод делегата UITextField вызывается, когда текстовое поле получает фокус
    func textFieldDidBeginEditing(_ textField: UITextField) {
        viewContainer.isActive = .active
        viewContainer.setNeedsDisplay()
        
        showPopup()
    }

    // Метод делегата UITextField вызывается, когда текстовое поле теряет фокус
    func textFieldDidEndEditing(_ textField: UITextField) {
        viewContainer.isActive = .inactive
        viewContainer.setNeedsDisplay()
    }
}

extension RegistrationPageViewController: RegistrationPageViewControllerDelegate {
    func didSelectValueInTextField(_ controller: PopupViewController, value: String) {
       textField.text = value
   }
}


extension RegistrationPageViewController {
    var _viewContainer: UICustomView {
        let view = UICustomView()
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        return view
    }
    
    var _textField: UITextField {
        let textField = UITextField()
        textField.borderStyle = .none
        textField.tintColor = .black
        return textField
    }
    
    var _buttonClick: WhiteButton {
        let button = WhiteButton()
        button.setTitle(R.string.localizable.cancelDeletionButton(), for: .normal)
        //button.setAttributedTitle(button.attributeString, for: .normal)
        
        button.setTitleColor(.black, for: .normal)
        //button.customView.isActive = .active
        //button.buttonState = .active
        //button.setSize(width: 315, height: 69)
        view.addSubview(button.customView)
        button.hasDashedBorder = true
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(buttonTap), for: .touchUpInside)
        return button
    }
    
    var _placeholderLabel: UILabel {
        let label = UILabel()
        label.text = R.string.localizable.genderPlaceholder()
        label.textAlignment = .center
        label.backgroundColor = .white
        label.textColor = UIColor.lightGray
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }
    
    func layout() {
        viewContainer.addSubview(textField)
        view.addSubview(viewContainer)
        view.addSubview(placeholderLabel)
        view.addSubview(buttonClick)
        
        viewContainer.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(150)
            make.left.equalToSuperview().offset(45)
            make.width.equalTo(300)
            make.height.equalTo(70)
        }
        
        textField.snp.makeConstraints { make in
            make.right.top.bottom.equalToSuperview().inset(0)
            make.left.equalToSuperview().inset(28)
        }
        
        placeholderLabel.snp.makeConstraints { make in
            make.top.equalTo(viewContainer.snp.bottom).inset(17)
            make.left.equalToSuperview().offset(65)
            make.width.equalTo(50)
            make.height.equalTo(30)
        }
        
        buttonClick.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.width.equalTo(315)
            make.height.equalTo(69)
        }
    }
}
