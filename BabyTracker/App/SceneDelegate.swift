//
//  SceneDelegate.swift
//  BabyTracker
//
//  Created by Мявкo on 23.06.23.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var appCoordinator: AppCoordinator?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        appCoordinator = AppCoordinator(windowScene: windowScene)
        appCoordinator?.start()

    }
}



