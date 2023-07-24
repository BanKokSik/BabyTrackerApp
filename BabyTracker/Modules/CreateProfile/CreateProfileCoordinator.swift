//
//  CreateProfileCoordinator.swift
//  BabyTracker
//
//  Created by Алексей Поддубный on 17.07.2023.
//

import UIKit

final class CreateProfileCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    
    var parent: Coordinator?
    
    private let navController: UINavigationController
    private var viewController: UIViewController?
    
    init(navController: UINavigationController, parent: Coordinator? = nil) {
        self.navController = navController
        self.parent = parent
    }
    
    func start() {
        let viewController = CreateProfileVC()
        self.viewController = viewController
    }
    
    func entry() -> UIViewController {
        guard let viewController = viewController as? CreateProfileVC else {
            fatalError("viewController is not CreateProfileVC")
        }
        return viewController
    }
    
    
}
