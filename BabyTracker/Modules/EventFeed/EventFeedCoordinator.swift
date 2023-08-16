//
//  EventFeedCoordinator.swift
//  BabyTracker
//
//  Created by Мявкo on 15.08.23.
//

import UIKit

final class EventFeedCoordinator: Coordinator {
    weak var parent: Coordinator?
    var childCoordinators: [Coordinator] = []
    
    private let navController: UINavigationController
    private var viewController: UIViewController?
    
    init(navController: UINavigationController, parent: Coordinator? = nil) {
        self.navController = navController
        self.parent = parent
    }
    
    func start() {
        let viewController = EventFeedViewController()
        viewController.coordinator = self
        self.viewController = viewController
    }
    
    func entry() -> UIViewController {
        guard let viewController = viewController as? EventFeedViewController else {
            fatalError("viewController is not EventFeedViewController")
        }
        return viewController
    }
}
