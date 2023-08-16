//
//  BabySettingsViewController.swift
//  BabyTracker
//
//  Created by Мявкo on 16.08.23.
//

import UIKit

class BabySettingsViewController: TestViewController {
    
    weak var coordinator: Coordinator?
    private var babySettingsCoordinator: BabySettingsCoordinator? { coordinator as? BabySettingsCoordinator }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = "Baby Settings View Controller"
    }
}
