//
//  CreateProfileCoordinator.swift
//  BabyTracker
//
//  Created by Алексей Поддубный on 17.07.2023.
//

import UIKit

protocol CreateProfileCoordinatorDelegate: AnyObject {
    func createProfileModuleDidFinish()
}

final class CreateProfileCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    weak var delegate: CreateProfileCoordinatorDelegate?
    
    var parent: Coordinator?
    var popupCoordinator: PopupCoordinator?
    
    private let navController: UINavigationController
    private var viewController: UIViewController?
    private let userProvider: UserApiProvider
    
    init(navController: UINavigationController,
         parent: Coordinator? = nil,
         userProvider: UserApiProvider) {
        self.navController = navController
        self.parent = parent
        self.userProvider = userProvider
    }
    
    func start() {
        let viewController = CreateProfileVC()
        let presenter = CreateProfilePresenterImpl(view: viewController,
                                                   userProvider: userProvider)
        viewController.presenter = presenter
        viewController.coordinator = self
        self.viewController = viewController
    }
    
    func entry() -> UIViewController {
        guard let viewController = viewController as? CreateProfileVC else {
            fatalError("viewController is not CreateProfileVC")
        }
        return viewController
    }
    
}

extension CreateProfileCoordinator: PopupCoordinatorDelegate {
    func didSelectValueInTextField(_ coordinator: PopupCoordinator, value: String, gender: Gender?) {
        guard let createProfileVC = viewController as? CreateProfileVC else { return }
        createProfileVC.setValueToGenderTextField(value: value, gender: gender)
    }
    
    func showPopup() {
        let popupCoordinator = PopupCoordinator(navController: navController, parent: self)
        popupCoordinator.start()
        popupCoordinator.delegate = self
        self.popupCoordinator = popupCoordinator
        
        guard let popup = popupCoordinator.entry() as? PopupViewController else { return }
        popup.openPopup(viewController as! CreateProfileVC)
    }
    
    func closePopup() {
        guard let popup = popupCoordinator?.entry() as? PopupViewController else { return }
        popup.closePopup()
    }
    
    func didFinish() {
        delegate?.createProfileModuleDidFinish()
    }
}
