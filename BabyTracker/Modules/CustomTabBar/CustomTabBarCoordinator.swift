//
//  TabBarCoordinator.swift
//  BabyTracker
//
//  Created by Мявкo on 3.08.23.
//

import UIKit

final class CustomTabBarCoordinator: Coordinator {
    
    weak var parent: Coordinator?
    var childCoordinators: [Coordinator] = []
    
    private let navController: UINavigationController
    private var viewController: UIViewController?
    
    init(navController: UINavigationController, parent: Coordinator? = nil) {
        self.navController = navController
        self.parent = parent
    }
    
    func start() {
        let viewController = CustomTabBarController()
        viewController.coordinator = self
        self.viewController = viewController
    }
    
    func entry() -> UIViewController {
        guard let viewController = viewController as? CustomTabBarController else {
            fatalError("viewController is not CustomTabBarController")
        }
        return viewController
    }
}
