//
//  AdvicesPageViewController.swift
//  BabyTracker
//
//  Created by Мявкo on 16.08.23.
//

import UIKit

class AdvicesPageViewController: TestViewController {
    
    weak var coordinator: Coordinator?
    private var advicesPageCoordinator: AdvicesPageCoordinator? { coordinator as? AdvicesPageCoordinator }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = "Advices Page View Controller"
    }
}
