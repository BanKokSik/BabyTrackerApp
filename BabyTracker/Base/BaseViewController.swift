//
//  BaseViewController.swift
//  BabyTracker
//
//  Created by Мявкo on 31.07.23.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
    }
}


class TestViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        layoutTitle()
    }
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20)
        label.textColor = .black
        return label
    }()
    
    func layoutTitle() {
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
    }
}
