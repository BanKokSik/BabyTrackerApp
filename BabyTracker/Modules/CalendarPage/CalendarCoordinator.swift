//
//  CalendarCoordinator.swift
//  BabyTracker
//
//  Created by Мявкo on 15.08.23.
//

import UIKit


final class CalendarCoordinator: Coordinator {
    weak var parent: Coordinator?
    var childCoordinators: [Coordinator] = []
    
    //weak var delegate: CalendarCoordinatorDelegate?
    
    private let navController: UINavigationController
    private var viewController: UIViewController?
    
    init(navController: UINavigationController, parent: Coordinator? = nil) {
        self.navController = navController
        self.parent = parent
    }
    
    func start() {
        let viewController = CalendarViewController()
        viewController.coordinator = self
        self.viewController = viewController
    }
    
    func entry() -> UIViewController {
        guard let viewController = viewController as? CalendarViewController else {
            fatalError("viewController is not CalendarViewController")
        }
        return viewController
    }
}
