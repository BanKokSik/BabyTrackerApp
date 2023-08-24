//
//  HeightPageCoordinator.swift
//  BabyTracker
//
//  Created by Мявкo on 16.08.23.
//

import UIKit

final class HeightPageCoordinator: Coordinator {
    weak var parent: Coordinator?
    var childCoordinators: [Coordinator] = []
    
    private let navController: UINavigationController
    private var viewController: UIViewController?
    
    init(navController: UINavigationController, parent: Coordinator? = nil) {
        self.navController = navController
        self.parent = parent
    }
    
    func start() {
        let viewController = HeightPageViewController()
        viewController.coordinator = self
        self.viewController = viewController
    }
    
    func entry() -> UIViewController {
        guard let viewController = viewController as? HeightPageViewController else {
            fatalError("viewController is not HeightPageViewController")
        }
        return viewController
    }
}
