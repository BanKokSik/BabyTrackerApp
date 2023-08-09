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
    
    private let navController: CustomNavigationController
    private let window: UIWindow
    
    private var onboardingCoordinator: OnboardingCoordinator?
    
    private var loaderCoordinator: LoaderCoordinator?
    private var registrationCoordinator: RegistrationCoordinator?
    private var createProfileCoordinator: CreateProfileCoordinator?
    private var subscriptionCoordinator: SubscriptionCoordinator?
    private var tabBarCoordinator: CustomTabBarCoordinator?
    
    init(navController: CustomNavigationController = CustomNavigationController(),
         windowScene: UIWindowScene) {
        self.navController = navController
        self.window = UIWindow(windowScene: windowScene)
    }
    
    func start() {
        let loaderCoordinator = LoaderCoordinator(navController: navController, parent: self)
        loaderCoordinator.start()
        self.loaderCoordinator = loaderCoordinator
        window.rootViewController = loaderCoordinator.entry()
        window.makeKeyAndVisible()
        childCoordinators.append(loaderCoordinator)
        let queue = DispatchQueue.global(qos: .utility)
        queue.asyncAfter(deadline: .now() + 3.0) {
            DispatchQueue.main.async {
                self.installOnbordingCoordinator()
            }
        }
    }
    
    func entry() -> UIViewController {
        return UIViewController()
    }
    
    private func removeAllSubmodules() {
        onboardingCoordinator = nil
        registrationCoordinator = nil
        createProfileCoordinator = nil
        subscriptionCoordinator = nil
        tabBarCoordinator = nil
    }
    
    private func installOnbordingCoordinator(){
        let onboardingCoordinator = OnboardingCoordinator(navController: navController, parent: self)
        onboardingCoordinator.start()
        onboardingCoordinator.delegate = self
        self.onboardingCoordinator = onboardingCoordinator
        window.rootViewController = onboardingCoordinator.entry()
        window.makeKeyAndVisible()
        
        childCoordinators.append(onboardingCoordinator)
    }
    
    private func installRegistrationCoordinator() {
        let registrationCoordinator = RegistrationCoordinator(navController: navController, parent: self)
        registrationCoordinator.start()
        registrationCoordinator.delegate = self
        removeAllSubmodules()
        self.registrationCoordinator = registrationCoordinator
        
        navController.viewControllers = [registrationCoordinator.entry()]
        window.rootViewController = navController
    }
    
    private func installCreateProfileCoordinator() {
        let createProfileCoordinator = CreateProfileCoordinator(navController: navController, parent: self)
        createProfileCoordinator.start()
        createProfileCoordinator.delegate = self
        self.createProfileCoordinator = createProfileCoordinator
        navController.pushViewController(createProfileCoordinator.entry(), animated: true)
        
        childCoordinators.append(createProfileCoordinator)
    }
    
    private func installSubscriptionCoordinator() {
        let subscriptionCoordinator = SubscriptionCoordinator(navController: navController, parent: self)
        subscriptionCoordinator.start()
        subscriptionCoordinator.delegate = self
        subscriptionCoordinator.presentSubscriptionsPopup()
        self.subscriptionCoordinator = subscriptionCoordinator
    }
    
    private func installTabBarCoordinator() {
        let tabBarCoordinator = CustomTabBarCoordinator(navController: navController, parent: self)
        tabBarCoordinator.start()
        self.tabBarCoordinator = tabBarCoordinator
        window.rootViewController = tabBarCoordinator.entry()
        window.makeKeyAndVisible()
        
        childCoordinators.append(tabBarCoordinator)
    }
}

extension AppCoordinator: OnboardingCoordinatorDelegate {
    func onboardingModuleDidFinish() {
        installRegistrationCoordinator()
    }
}

extension AppCoordinator: RegistrationCoordinatorDelegate {
    func registrationModuleDidFinish() {
        installCreateProfileCoordinator()
    }
}

extension AppCoordinator: CreateProfileCoordinatorDelegate {
    func createProfileModuleDidFinish() {
        installSubscriptionCoordinator()
    }
}

extension AppCoordinator: SubscriptionCoordinatorDelegate {
    func subscriptionModuleDidFinish() {
        installTabBarCoordinator()
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
