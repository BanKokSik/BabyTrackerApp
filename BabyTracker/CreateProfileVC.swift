//
//  CreateProfileVC.swift
//  BabyTracker
//
//  Created by Nikita Chekmarev on 25.06.2023.
//

import UIKit
import SnapKit

class CreateProfileVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialaze()
    }
    
    private func initialaze(){
        
        view.backgroundColor = UIColor.white
        title = "Create profile"
        let createIV = UIImageView()
        createIV.backgroundColor = UIColor.black
        view.addSubview(createIV)
        createIV.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalTo(182)
            make.height.equalTo(156)
            make.top.equalToSuperview().inset(118)
            
        }
        
        
        
    }
}
