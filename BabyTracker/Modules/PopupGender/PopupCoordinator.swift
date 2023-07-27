//
//  PopupCoordinator.swift
//  BabyTracker
//
//  Created by Мявкo on 21.07.23.
//

import UIKit

protocol PopupCoordinatorDelegate: AnyObject {
    func didSelectValueInTextField(_ coordinator: PopupCoordinator, value: String, gender: Gender?)
    func closePopup()
}

final class PopupCoordinator: Coordinator {
    weak var parent: Coordinator?
    var childCoordinators: [Coordinator] = []
    weak var delegate: PopupCoordinatorDelegate?
    
    private let navController: UINavigationController
    private var viewController: UIViewController?
    
    init(navController: UINavigationController, parent: Coordinator? = nil) {
        self.navController = navController
        self.parent = parent
    }
    
    func start() {
        let viewController = PopupViewController()
        viewController.coordinator = self
        self.viewController = viewController
    }
    
    func entry() -> UIViewController {
        guard let viewController = viewController as? PopupViewController else {
            fatalError("viewController is not PopupViewController")
        }
        return viewController
    }
    
    func setValueInTextField(_ selectedValue: String) {
        guard let popup = viewController as? PopupViewController else { return }
        delegate?.didSelectValueInTextField(self, value: selectedValue, gender: popup.presenter?.gender)
    }
    
    func closePopup() {
        delegate?.closePopup()
    }
}
