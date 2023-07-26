//
//  RegistrationCoordinator.swift
//  BabyTracker
//
//  Created by Мявкo on 18.07.23.
//

import UIKit

protocol RegistrationCoordinatorDelegate: AnyObject {
    func registrationModuleDidFinish()
}

final class RegistrationCoordinator: Coordinator {
    weak var parent: Coordinator?
    var childCoordinators: [Coordinator] = []
    weak var delegate: RegistrationCoordinatorDelegate?
    
    private let navController: UINavigationController
    private var viewController: UIViewController?
    
    init(navController: UINavigationController, parent: Coordinator? = nil) {
        self.navController = navController
        self.parent = parent
    }
    
    func start() {
        let viewController = RegisterViewController()
        viewController.coordinator = self
        self.viewController = viewController
    }
    
    func entry() -> UIViewController {
        guard let viewController = viewController as? RegisterViewController else {
            fatalError("viewController is not RegisterViewController")
        }
        return viewController
    }
    
    func didFinish() {
        delegate?.registrationModuleDidFinish()
    }
}
