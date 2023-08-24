//
//  OnboardingCoordinator.swift
//  BabyTracker
//
//  Created by Алексей Поддубный on 17.07.2023.
//

import UIKit

protocol OnboardingCoordinatorDelegate: AnyObject {
    func onboardingModuleDidFinish()
}

final class OnboardingCoordinator: Coordinator {
    weak var parent: Coordinator?
    var childCoordinators: [Coordinator] = []
    weak var delegate: OnboardingCoordinatorDelegate?
    
    private let registerProvider: RegisterApiProvider
    private let navController: UINavigationController
    private var viewController: UIViewController?
    
    init(navController: UINavigationController,
         parent: Coordinator? = nil,
         registerProvider: RegisterApiProvider) {
        self.navController = navController
        self.parent = parent
        self.registerProvider = registerProvider
    }
    
    func start() {
        let viewController = PageViewController()
        let presenter = PagePresenter(view: viewController,
                                      registerProvider: registerProvider)
        viewController.presenter = presenter
        viewController.coordinator = self
        self.viewController = viewController 
    }
    
    func entry() -> UIViewController {
        guard let viewController = viewController as? PageViewController else {
            fatalError("viewController is not PageViewController")
        }
        return viewController
    }
    
    func didFinish() {
        delegate?.onboardingModuleDidFinish()
    }
}
