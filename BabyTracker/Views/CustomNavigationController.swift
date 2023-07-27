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
        let backButtonImage = UIImage(resource: R.image.back)
        navigationBar.backIndicatorImage = backButtonImage?.withAlignmentRectInsets(UIEdgeInsets(top: 0,
                                                                                                left: -20,
                                                                                                bottom: 0,
                                                                                                right: 0))
        navigationBar.backIndicatorTransitionMaskImage = backButtonImage
        navigationBar.tintColor = .lightGray
        navigationBar.topItem?.title = "" // Пустая строка, чтобы убрать название "Назад"
    }
}
