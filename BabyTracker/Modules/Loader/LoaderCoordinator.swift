//
//  LoaderCoordinator.swift
//  BabyTracker
//
//  Created by Nikita Chekmarev on 20.07.2023.
//

import Foundation
import UIKit

protocol LoaderCoordinatorDelegate: AnyObject {
    func loaderModuleDidFinish()
}

final class LoaderCoordinator: Coordinator {
    weak var parent: Coordinator?
    var childCoordinators: [Coordinator] = []
    weak var delegate: LoaderCoordinatorDelegate?
    
    private let navController: UINavigationController
    private var viewController: UIViewController?
    
    init(navController: UINavigationController, parent: Coordinator? = nil) {
        self.navController = navController
        self.parent = parent
    }
    
    func start() {
        let viewController = LoaderViewController()
        viewController.coordinator = self
        self.viewController = viewController
    }
    
    func entry() -> UIViewController {
        guard let viewController = viewController as? LoaderViewController else {
            fatalError("viewController is not PageViewController")
        }
        return viewController
    }
    
    func didFinish() {
        delegate?.loaderModuleDidFinish()
    }
}
