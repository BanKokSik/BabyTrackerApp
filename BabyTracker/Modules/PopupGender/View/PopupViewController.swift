//
//  PopupViewController.swift
//  BabyTracker
//
//  Created by Мявкo on 11.07.23.
//

import UIKit
import SnapKit

protocol PopupPresenterDelegate: AnyObject {
    func didSelectGender(_ controller: PopupViewController, gender: Gender?)
}

protocol PopupViewControllerDelegate: AnyObject {
    
}

class PopupViewController: UIViewController {
    
    var presenter: PopupPresenter?
    weak var delegate: PopupPresenterDelegate?
    
    weak var coordinator: Coordinator?
    private var popupCoordinator: PopupCoordinator? { coordinator as? PopupCoordinator }
    
    var blurView: UIVisualEffectView?
    
    private lazy var boyView: BorderView = _boyView
    private lazy var boyImageView: UIImageView = _boyImageView
    private lazy var boyLabel: UILabel = _boyLabel
    
    private lazy var girlView: BorderView = _girlView
    private lazy var girlImageView: UIImageView = _girlImageView
    private lazy var girlLabel: UILabel = _girlLabel
    
    private lazy var checkmarkImageView: UIImageView = _checkmarkImageView
    
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
    
    func configureTapGesture(for view: BorderView, action: Selector) {
        let tapGesture = UITapGestureRecognizer(target: self, action: action)
        view.addGestureRecognizer(tapGesture)
        view.isUserInteractionEnabled = true
    }
    
    @objc private func boyIsTapped() {
        delegate?.didSelectGender(self, gender: .boy)
    }
    
    @objc private func girlIsTapped() {
        delegate?.didSelectGender(self, gender: .girl)
    }
    
    func hidePopup() {
        popupCoordinator?.closePopup()
    }
    
    func setValueInTextField(_ selectedValue: String) {
        popupCoordinator?.setValueInTextField(selectedValue)
    }
    
    func openPopup(_ controller: CreateProfileVC) {
        controller.makeBackgroundBlur()
        genderIsChosen(controller)
        
        view.center = controller.view.center
        blurView = controller.blurView

        controller.view.addSubview(view)

        view.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        view.alpha = 0.0
        UIView.animate(withDuration: 0.2) {
            self.view.transform = CGAffineTransform.identity
            self.view.alpha = 1.0
        }
    }
    
    func genderIsChosen(_ controller: CreateProfileVC) {
        let gender = controller.activeGender
        if gender == .boy {
            toggleViewActiveStateOnBoy()
            layoutCheckmarkOnBoy()
        } else if gender == .girl {
            toggleViewActiveStateOnGirl()
            layoutCheckmarkOnGirl()
        }
    }
    
    func closePopup() {
        removeBackgroundBlur()
        closePopupWithAnimation()
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
    
    func toggleViewActiveState(_ view: BorderView, otherView: BorderView) {
        
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
    
    var _boyView: BorderView {
        let view = BorderView()
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
    
    var _girlView: BorderView {
        let view = BorderView()
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
    
    func layoutCheckmark(_ gender: BorderView) {
        gender.addSubview(checkmarkImageView)
        checkmarkImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(27)
            make.leading.equalToSuperview().inset(207)
            make.trailing.equalToSuperview().inset(23)
        }
    }
}
