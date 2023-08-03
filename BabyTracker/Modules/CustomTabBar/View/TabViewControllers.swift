//
//  TabViewControllers.swift
//  BabyTracker
//
//  Created by Мявкo on 3.08.23.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
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

class FirstViewController: ViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = "First View Controller"
    }
}

class SecondViewController: ViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = "Second View Controller"
    }
}

class ThirdViewController: ViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = "Third View Controller"
    }
}

class FourthViewController: ViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = "Fourth View Controller"
    }
}

class FifthViewController: ViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = "Fifth View Controller"
    }
}

class SixthViewController: ViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = "Sixth View Controller"
    }
}

