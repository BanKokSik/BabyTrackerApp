//
//  LoaderViewController.swift
//  BabyTracker
//
//  Created by Nikita Chekmarev on 19.07.2023.
//

import UIKit
import SnapKit
protocol LoaderViewControllerDelegate: AnyObject{
    
}

class LoaderViewController: UIViewController {
    weak var coordinator: Coordinator?
    private var loaderCoordinator: LoaderCoordinator? { coordinator as? LoaderCoordinator }

    weak var delegate: LoaderViewControllerDelegate?
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
    
}
