//
//  SubscriptionCoordinator.swift
//  BabyTracker
//
//  Created by Мявкo on 20.07.23.
//

import UIKit

protocol SubscriptionCoordinatorDelegate: AnyObject {
    func subscriptionModuleDidFinish()
}

final class SubscriptionCoordinator: Coordinator {
    weak var parent: Coordinator?
    var childCoordinators: [Coordinator] = []
    weak var delegate: SubscriptionCoordinatorDelegate?
    
    private let navController: UINavigationController
    private var viewController: UIViewController?
    
    init(navController: UINavigationController, parent: Coordinator? = nil) {
        self.navController = navController
        self.parent = parent
    }
    
    func start() {
        let viewController = SubscriptionViewController()
        viewController.coordinator = self
        self.viewController = viewController
    }
    
    func entry() -> UIViewController {
        guard let viewController = viewController as? SubscriptionViewController else {
            fatalError("viewController is not SubscriptionViewController")
        }
        return viewController
    }
    
    func presentSubscriptionsPopup() {
        guard let subscriptions = viewController as? SubscriptionViewController else { return }
        
        let popupNavController = UINavigationController(rootViewController: subscriptions)
        popupNavController.modalPresentationStyle = .fullScreen
        popupNavController.modalTransitionStyle = .coverVertical
        
        navController.present(popupNavController, animated: true, completion: nil)
    }
    
    func didFinish() {
        delegate?.subscriptionModuleDidFinish()
    }
}
