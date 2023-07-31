//
//  LoaderViewController.swift
//  BabyTracker
//
//  Created by Nikita Chekmarev on 19.07.2023.
//

import UIKit
import SnapKit

protocol LoaderViewControllerDelegate: AnyObject {}

class LoaderViewController: UIViewController {
    weak var coordinator: Coordinator?
    weak var delegate: LoaderViewControllerDelegate?
    
    private var loaderCoordinator: LoaderCoordinator? { coordinator as? LoaderCoordinator }
    
    let deviceId = UIDevice.current.identifierForVendor?.uuidString
    private lazy var loaderImageView: UIImageView = _loaderImageView
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = R.color.heliotrope()
        
        setupSubviews()
        applyConstraints()
        
        UserDefaultsSettings.setupDeviceId = deviceId
    }
    
    private func setupSubviews() {
        view.addSubview(loaderImageView)
    }
    
    private func applyConstraints() {
        loaderImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.height.equalTo(296)
            make.width.equalTo(375)
        }
    }
}

private extension LoaderViewController {
    var _loaderImageView: UIImageView {
        let result = UIImageView()
        result.image = UIImage(named: "BabyLogo")
        return result
    }
}
