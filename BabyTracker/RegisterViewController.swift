//
//  ViewController.swift
//  BabyTracker
//
//  Created by Мявкo on 23.06.23.
//

import UIKit

class RegisterViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
    
    
    private func initialize() {
        view.backgroundColor = UIColor.white
        
        
        let createpProfileButton = UIButton(type: .system)
        createpProfileButton.backgroundColor = UIColor.rgb(red: 207, green: 104, blue: 255)
        createpProfileButton.layer.cornerRadius = 10
        createpProfileButton.setTitle("Создать профиль", for: .normal)
        createpProfileButton.setTitleColor(.white, for: .normal)
        view.addSubview(createpProfileButton)
        createpProfileButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalTo(315)
            make.height.equalTo(69)
            make.top.equalToSuperview().inset(286)
        }
        let enterCodeButton = UIButton(type: .system)
        
        enterCodeButton.setTitle("Ввести код", for: .normal)
        enterCodeButton.setTitleColor(UIColor(red: 180/255, green: 180/255, blue: 180/255, alpha: 1), for: .normal)
        enterCodeButton.backgroundColor = UIColor.white
        enterCodeButton.layer.borderWidth = 2
        enterCodeButton.layer.cornerRadius = 10
        enterCodeButton.layer.borderColor = CGColor.init(red: 180/255, green: 180/255, blue: 180/255, alpha: 0.1)
        view.addSubview(enterCodeButton)
        enterCodeButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalTo(313)
            make.height.equalTo(71)
            make.top.equalTo(createpProfileButton).inset(100)
        }
        let restoreCloudButton = UIButton(type: .system)
        
        restoreCloudButton.setTitle("Восстановить из облака", for: .normal)
        restoreCloudButton.setTitleColor(.black, for: .normal)
        
        view.addSubview(restoreCloudButton)
        restoreCloudButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalTo(245)
            make.height.equalTo(22)
            make.top.equalTo(enterCodeButton).inset(100)
        }
        
        
    }


}

