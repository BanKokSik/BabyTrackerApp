//
//  LoaderViewController.swift
//  BabyTracker
//
//  Created by Nikita Chekmarev on 29.06.2023.
//

import UIKit
import SnapKit

class LoaderViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        initialize()
        setupConstraints()
    }
    let deviceId = UIDevice.current.identifierForVendor?.uuidString
    
    private func initialize(){
        view.backgroundColor = UIColor.rgb(red: 207, green: 105, blue: 255)
        UserDefaultsSettings.setupDeviceId = deviceId
        view.addSubview(loaderImageView)
    }
   private let loaderImageView: UIImageView = {
        let loader = UIImageView()
       loader.image = UIImage(named: "BabyLogo")
       
        
        return loader
    }()
    private func setupConstraints(){
        loaderImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.height.equalTo(296)
            make.width.equalTo(375)
            
        }
    }
    private func makeServiceCall() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
          
       }
    }
    func showNextVC() {
        let queue = DispatchQueue.global(qos: .utility)
        queue.asyncAfter(deadline: .now() + 5.0) {
            DispatchQueue.main.async {
                let lVC = LoaderViewController()
                lVC.show(RegisterViewController(), sender: LoaderViewController())
            }
            
        }
        
    }
    
    
   
}
