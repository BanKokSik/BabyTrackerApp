//
//  AppCoordinator.swift
//  BabyTracker
//
//  Created by Алексей Поддубный on 17.07.2023.
//

import UIKit

final class AppCoordinator: NSObject, Coordinator {
    
    weak var parent: Coordinator?
    var childCoordinators: [Coordinator] = []
    
    private let navController: UINavigationController
    private let window: UIWindow
    
    private var onboardingCoordinator: OnboardingCoordinator?
    private var createProfileCoordinator: CreateProfileCoordinator?
    
    init(navController: UINavigationController = UINavigationController(),
         windowScene: UIWindowScene) {
        self.navController = navController
        self.window = UIWindow(windowScene: windowScene)
    }
    
    func start() {
        let onboardingCoordinator = OnboardingCoordinator(navController: navController, parent: self)
        onboardingCoordinator.start()
        onboardingCoordinator.delegate = self
        self.onboardingCoordinator = onboardingCoordinator
        window.rootViewController = onboardingCoordinator.entry()
        window.makeKeyAndVisible()

        childCoordinators.append(onboardingCoordinator)
    }
    
    func entry() -> UIViewController {
        return UIViewController()
    }
    
    private func removeAllSubmodules() {
        onboardingCoordinator = nil
        createProfileCoordinator = nil
    }
    
    private func installCreateProfileCoordinator() {
        let createProfileCoordinator = CreateProfileCoordinator(navController: navController, parent: self)
        createProfileCoordinator.start()
        removeAllSubmodules()
        self.createProfileCoordinator = createProfileCoordinator
        window.rootViewController = createProfileCoordinator.entry()
    }
}

extension AppCoordinator: OnboardingCoordinatorDelegate {
    func onboardingModuleDidFinish() {
        installCreateProfileCoordinator()
    }
}

extension AppCoordinator: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        guard let fromViewController = navigationController.transitionCoordinator?.viewController(forKey: .from),
            !navigationController.viewControllers.contains(fromViewController) else {
                return
        }
        
        if let viewController = fromViewController as? Coordinatable {
            let parent = viewController.coordinator?.parent
            parent?.childCoordinators.removeAll { $0 === viewController.coordinator }
        }
    }
}
