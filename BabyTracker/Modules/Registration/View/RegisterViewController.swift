//
//  ViewController.swift
//  BabyTracker
//
//  Created by Мявкo on 23.06.23.
//

import UIKit
import SnapKit

protocol RegisterViewControllerDelegate: AnyObject {}

protocol RegisterViewProtocol: AnyObject {}

class RegisterViewController: BaseViewController {

    weak var delegate: RegisterViewControllerDelegate?
    
    weak var coordinator: Coordinator?
    private var registrationCoordinator: RegistrationCoordinator? { coordinator as? RegistrationCoordinator }
    
    private lazy var createProfileButton: UIButton = _createProfileButton
    private lazy var enterCodeButton: UIButton = _enterCodeButton
    private lazy var restoreCloudButton: UIButton = _restoreCloudButton

    override func viewDidLoad() {
        super.viewDidLoad()

        setupSubviews()
        applyConstraints()
    }
    
    private func setupSubviews() {
        view.addSubview(createProfileButton)
        view.addSubview(enterCodeButton)
        view.addSubview(restoreCloudButton)
    }
    
    private func applyConstraints () {
        createProfileButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(29)
            make.height.equalTo(69)
            make.top.equalToSuperview().inset(286)
        }
        
        enterCodeButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(29)
            make.height.equalTo(71)
            make.top.equalTo(createProfileButton).inset(100)
        }
        
        restoreCloudButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(29)
            make.height.equalTo(22)
            make.top.equalTo(enterCodeButton).inset(100)
        }
    }
    
    @objc private func createProfileButtonTapped(){
        registrationCoordinator?.didFinish()
    }
}

extension RegisterViewController {
    
    var _createProfileButton: UIButton {
        let button = UIButton(type: .system)
        button.backgroundColor = R.color.heliotrope()
        button.layer.cornerRadius = 10
        button.setTitle(R.string.localizable.createProfileButton(), for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(createProfileButtonTapped), for: .touchUpInside)
        return button
    }
    
    var _enterCodeButton: UIButton {
        let button = UIButton(type: .system)
        button.setTitle(R.string.localizable.enterTheCodeButton(), for: .normal)
        button.setTitleColor(R.color.silver(), for: .normal)
        button.backgroundColor = R.color.white()
        button.layer.borderWidth = 2
        button.layer.cornerRadius = 10
        button.layer.borderColor = R.color.wildSand()?.cgColor
        return button
    }
    
    var _restoreCloudButton: UIButton {
        let button = UIButton(type: .system)
        button.setTitle(R.string.localizable.restoreFromTheCloudButton(), for: .normal)
        button.setTitleColor(.black, for: .normal)
        return button
    }
}
