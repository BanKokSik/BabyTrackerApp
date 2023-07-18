//
//  PopupViewController.swift
//  BabyTracker
//
//  Created by Мявкo on 11.07.23.
//

import UIKit
import SnapKit

protocol RegistrationPageViewControllerDelegate: AnyObject {
    func didSelectValueInTextField(_ controller: PopupViewController, value: String)
}

protocol PopupPresenterDelegate: AnyObject {
    func didSelectGender(_ controller: PopupViewController, gender: Gender?)
}

class PopupViewController: UIViewController, ViewControllerDelegate {
    
    private var presenter: PopupPresenter?
    
    var blurView: UIVisualEffectView?
    
    private lazy var boyView: UICustomView = _boyView
    private lazy var boyImageView: UIImageView = _boyImageView
    private lazy var boyLabel: UILabel = _boyLabel
    
    private lazy var girlView: UICustomView = _girlView
    private lazy var girlImageView: UIImageView = _girlImageView
    private lazy var girlLabel: UILabel = _girlLabel
    
    private lazy var checkmarkImageView: UIImageView = _checkmarkImageView
    
    weak var delegateRegistration: RegistrationPageViewControllerDelegate?
    weak var delegatePresenter: PopupPresenterDelegate?
    
    init() {
        super.init(nibName: nil, bundle: nil)
        presenter = PopupPresenter(self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTapGestureBoth()
        layout()
    }
    
    func configureTapGestureBoth() {
        configureTapGesture(for: boyView, action: #selector(boyIsTapped))
        configureTapGesture(for: girlView, action: #selector(girlIsTapped))
    }
    
    func configureTapGesture(for view: UICustomView, action: Selector) {
        let tapGesture = UITapGestureRecognizer(target: self, action: action)
        view.addGestureRecognizer(tapGesture)
        view.isUserInteractionEnabled = true
    }
    
    @objc private func boyIsTapped() {
        delegatePresenter?.didSelectGender(self, gender: .boy)
    }
    
    @objc private func girlIsTapped() {
        delegatePresenter?.didSelectGender(self, gender: .girl)
    }
    
    func setValueInTextField(_ selectedValue: String) {
        delegateRegistration?.didSelectValueInTextField(self, value: selectedValue)
    }
    
    let durationOfClosing = 0.4
    
    func removeBackgroundBlur() {
        UIView.animate(withDuration: durationOfClosing, animations: {
            self.blurView?.alpha = 0
        }, completion: { finished in
            self.blurView?.removeFromSuperview()
        })
    }
    
    func closePopupWithAnimation() {
        UIView.animate(withDuration: durationOfClosing, animations: {
            self.view.alpha = 0
        }, completion: { finished in
            self.dismiss(animated: false, completion: nil)
        })
    }
    
    func layoutCheckmarkOnGirl() {
        layoutCheckmark(girlView)
    }
    
    func layoutCheckmarkOnBoy() {
        layoutCheckmark(boyView)
    }
    
    func toggleViewActiveStateOnGirl() {
        toggleViewActiveState(girlView, otherView: boyView)
    }
    
    func toggleViewActiveStateOnBoy() {
        toggleViewActiveState(boyView, otherView: girlView)
    }
    
    func toggleViewActiveState(_ view: UICustomView, otherView: UICustomView) {
        
        guard view.isActive != .active else { return }
        otherView.isActive = .inactive
        view.isActive = .active
        
        view.setNeedsDisplay()
        otherView.setNeedsDisplay()
    }
}

extension PopupViewController {
    var _boyImageView: UIImageView {
        let imageView = UIImageView()
        imageView.image = presenter?.boy.image
        return imageView
    }
    
    var _boyLabel: UILabel {
        let label = UILabel()
        label.text = presenter?.boy.title
        return label
    }
    
    var _boyView: UICustomView {
        let view = UICustomView()
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        view.color = UIColor.white
        view.lineWidth = 5
        view.dashPattern = [4, 4]
        return view
    }
    
    var _girlImageView: UIImageView {
        let imageView = UIImageView()
        imageView.image = presenter?.girl.image
        return imageView
    }
    
    var _girlLabel: UILabel {
        let label = UILabel()
        label.text = presenter?.girl.title
        return label
    }
    
    var _girlView: UICustomView {
        let view = UICustomView()
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        view.color = UIColor.white
        view.lineWidth = 5
        view.dashPattern = [4, 4]
        return view
    }
    
    var _checkmarkImageView: UIImageView {
        let imageView = UIImageView()
        imageView.image = R.image.checkmark()
        return imageView
    }
    
    func layout() {
        boyView.addSubview(boyImageView)
        boyView.addSubview(boyLabel)
        view.addSubview(boyView)
        
        girlView.addSubview(girlImageView)
        girlView.addSubview(girlLabel)
        view.addSubview(girlView)
        
        boyView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(155)
            make.centerX.equalToSuperview()
            make.height.width.equalTo(250)
        }
        
        boyImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(59)
            make.centerX.equalToSuperview()
            make.width.equalTo(122)
            make.height.equalTo(100)
        }
        
        boyLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(55)
            make.centerX.equalToSuperview()
        }

        girlView.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(155)
            make.centerX.equalToSuperview()
            make.height.width.equalTo(250)
        }
        
        girlImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(47)
            make.centerX.equalToSuperview()
            make.width.equalTo(122)
            make.height.equalTo(122)
        }
        
        girlLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(48)
            make.centerX.equalToSuperview()
        }
    }
    
    func layoutCheckmark(_ gender: UICustomView) {
        gender.addSubview(checkmarkImageView)
        checkmarkImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(27)
            make.leading.equalToSuperview().inset(207)
            make.trailing.equalToSuperview().inset(23)
        }
    }
}
