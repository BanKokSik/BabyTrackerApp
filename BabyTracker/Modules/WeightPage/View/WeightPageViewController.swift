//
//  WeightPageViewController.swift
//  BabyTracker
//
//  Created by Мявкo on 16.08.23.
//

import UIKit

class WeightPageViewController: TestViewController {
    
    weak var coordinator: Coordinator?
    private var weightPageCoordinator: WeightPageCoordinator? { coordinator as? WeightPageCoordinator }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = "Weight Page View Controller"
    }
}
