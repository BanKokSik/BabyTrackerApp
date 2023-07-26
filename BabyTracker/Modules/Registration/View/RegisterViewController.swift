//
//  ViewController.swift
//  BabyTracker
//
//  Created by Мявкo on 23.06.23.
//

import UIKit
import SnapKit

protocol RegisterViewControllerDelegate: AnyObject {
    
}

protocol RegisterViewProtocol: AnyObject {
    
}

class RegisterViewController: UIViewController {
    
    weak var delegate: RegisterViewControllerDelegate?
    
    weak var coordinator: Coordinator?
    private var registrationCoordinator: RegistrationCoordinator? { coordinator as? RegistrationCoordinator }

    override func viewDidLoad() {
        super.viewDidLoad()
            
        initialize()
        setupConstraints()
    
        createProfileButton.addTarget(self, action: #selector(createProfileButtonTapped), for: .touchUpInside)
    }
    
     private let createProfileButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor.rgb(red: 207, green: 104, blue: 255)
        button.layer.cornerRadius = 10
        button.setTitle("Создать профиль", for: .normal)
        button.setTitleColor(.white, for: .normal)
        
        return button
    }()
    private let enterCodeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Ввести код", for: .normal)
        button.setTitleColor(UIColor(red: 180/255, green: 180/255, blue: 180/255, alpha: 1), for: .normal)
        button.backgroundColor = UIColor.white
        button.layer.borderWidth = 2
        button.layer.cornerRadius = 10
        button.layer.borderColor = CGColor.init(red: 180/255, green: 180/255, blue: 180/255, alpha: 0.1)
        
        return button
    }()
    private let restoreCloudButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Восстановить из облака", for: .normal)
        button.setTitleColor(.black, for: .normal)

        return button
    }()
    
    
    private func setupConstraints () {
        createProfileButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalTo(315)
            make.height.equalTo(69)
            make.top.equalToSuperview().inset(286)
        }
        enterCodeButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalTo(313)
            make.height.equalTo(71)
            make.top.equalTo(createProfileButton).inset(100)
        }
        restoreCloudButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalTo(245)
            make.height.equalTo(22)
            make.top.equalTo(enterCodeButton).inset(100)
        }
    }
   
    func initialize() {
        view.backgroundColor = UIColor.white
        view.addSubview(createProfileButton)
        view.addSubview(enterCodeButton)
        view.addSubview(restoreCloudButton)
    }
    
    @objc private func createProfileButtonTapped(){
        registrationCoordinator?.didFinish()
    }
}

