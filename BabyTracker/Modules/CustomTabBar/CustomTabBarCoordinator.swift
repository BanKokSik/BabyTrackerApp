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
    var viewControllers: [UIViewController] = []
    
    private let navController: UINavigationController
    private var viewController: UIViewController?
    
    init(navController: UINavigationController, parent: Coordinator? = nil) {
        self.navController = navController
        self.parent = parent
        
        self.childCoordinators = initChildCoordinators()
        self.viewControllers = initViewControllers()
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
    
    func initChildCoordinators() -> [Coordinator] {
        let coordinators: [Coordinator] = [
            EventFeedCoordinator(navController: navController, parent: self),
            CalendarCoordinator(navController: navController, parent: self),
            HeightPageCoordinator(navController: navController, parent: self),
            WeightPageCoordinator(navController: navController, parent: self),
            AdvicesPageCoordinator(navController: navController, parent: self),
            BabySettingsCoordinator(navController: navController, parent: self)
        ]
        return coordinators
    }
    
    func initViewControllers() -> [UIViewController] {
        let viewControllers = childCoordinators.map { coordinator in
            coordinator.start()
            return coordinator.entry()
        }
        return viewControllers
    }
}
