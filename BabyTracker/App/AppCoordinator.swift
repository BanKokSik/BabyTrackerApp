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
    private var registerCoordinator: RegisterCoordinator?
    private var createProfileCoordinator: CreateProfileCoordinator?
    private var loaderCoordinator: LoaderCoordinator?
    
    init(navController: UINavigationController = UINavigationController(),
         windowScene: UIWindowScene) {
        self.navController = navController
        self.window = UIWindow(windowScene: windowScene)
    }
    
    func start() {
        let loaderCoordinator = LoaderCoordinator(navController: navController, parent: self)
        loaderCoordinator.start()
//        loaderCoordinator.delegate = self
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
        
//        let onboardingCoordinator = OnboardingCoordinator(navController: navController, parent: self)
//        onboardingCoordinator.start()
//        onboardingCoordinator.delegate = self
//        self.onboardingCoordinator = onboardingCoordinator
//        window.rootViewController = onboardingCoordinator.entry()
//        window.makeKeyAndVisible()
//
//        childCoordinators.append(onboardingCoordinator)
        
    }
    
    func entry() -> UIViewController {
        return UIViewController()
    }
    
    private func removeAllSubmodules() {
        onboardingCoordinator = nil
        registerCoordinator = nil
        createProfileCoordinator = nil
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
    private func installRegisterCoordinator() {
        let registrationCoordinator = RegisterCoordinator(navController: navController, parent: self)
        registrationCoordinator.start()
        registrationCoordinator.delegate = self
        removeAllSubmodules()
        self.registerCoordinator = registrationCoordinator
        navController.viewControllers = [registrationCoordinator.entry()]
        window.rootViewController = navController
        print("Устанавливаем Экран регистрации")
    }
    private func installCreateProfileCoordinator(){
        let createProfileCoordinator = CreateProfileCoordinator(navController: navController, parent: self)
        createProfileCoordinator.start()
        
//        removeAllSubmodules()
        self.createProfileCoordinator = createProfileCoordinator
        navController.pushViewController(createProfileCoordinator.entry(), animated: true)
//        window.rootViewController = createProfileCoordinator.entry()
        childCoordinators.append(createProfileCoordinator)
        print("Устанавливаем Экран создания профиля")
    }
}

extension AppCoordinator: OnboardingCoordinatorDelegate {
    func onboardingModuleDidFinish() {
        installRegisterCoordinator()
        print("Делегат онбординг")
    }
    
}
extension AppCoordinator: RegisterCoordinatorDelegate{
    func registerModuleDidFinfsh() {
        installCreateProfileCoordinator()
        print("Делегат регистрации")
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
