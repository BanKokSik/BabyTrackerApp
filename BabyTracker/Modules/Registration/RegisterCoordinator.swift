//
//  RegistrationCoordinator.swift
//  BabyTracker
//
//  Created by Nikita Chekmarev on 17.07.2023.
//

import UIKit
protocol RegisterCoordinatorDelegate: AnyObject{
    func registerModuleDidFinfsh()
}

final class RegisterCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    
    var parent: Coordinator?
   weak var delegate: RegisterCoordinatorDelegate?
    
    private let navController: UINavigationController
    private var viewController: UIViewController?
    
   
    init(navController: UINavigationController , parent: Coordinator? = nil) {
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
            fatalError("viewController is not CreateProfileVC")
        }
        return viewController
    }
    func didFinish(){
        delegate?.registerModuleDidFinfsh()
        print("Финишируем")
        
    }
    
    
}
