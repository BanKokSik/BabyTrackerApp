//
//  CustomNavController.swift
//  BabyTracker
//
//  Created by Мявкo on 24.07.23.
//

import UIKit

class CustomNavigationController: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationBar()
    }
    
    private func setupNavigationBar() {
        let backButtonImage = UIImage(named: "Back")?.withAlignmentRectInsets(UIEdgeInsets(top: 0, left: -20, bottom: 0, right: 0))
        navigationBar.backIndicatorImage = backButtonImage
        navigationBar.backIndicatorTransitionMaskImage = UIImage(named: "Back")
        navigationBar.tintColor = .lightGray
        navigationBar.topItem?.title = "" // Пустая строка, чтобы убрать название "Назад"
    }
}
