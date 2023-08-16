//
//  HeightPageViewController.swift
//  BabyTracker
//
//  Created by Мявкo on 16.08.23.
//


import UIKit

class HeightPageViewController: TestViewController {
    
    weak var coordinator: Coordinator?
    private var heightPageCoordinator: HeightPageCoordinator? { coordinator as? HeightPageCoordinator }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = "Height Page View Controller"
    }
}
